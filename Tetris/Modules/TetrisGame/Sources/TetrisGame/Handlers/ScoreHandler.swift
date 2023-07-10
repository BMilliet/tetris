import Foundation

struct User {
    let id: String
    let name: String
    let score: Int

    init(id: String = UUID().uuidString, name: String, score: Int) {
        self.id = id
        self.name = name
        self.score = score
    }
}

enum ScoreHandler {
    static func save(_ user: User) {
        removeLowest()
        let value: [String: Int] = [user.name: user.score]
        UserDefaults.standard.set(value, forKey: user.id)
    }

    static func remove(_ id: String) {
        UserDefaults.standard.removeObject(forKey: id)
    }

    static func getAll() -> [User] {
        var list = [User]()

        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            guard let hash = value as? [String: Int] else { continue }
            let user = User(id: key, name: hash.keys.first!, score: hash.values.first!)
            list.append(user)
        }

        return list
    }

    static func isScoreInTop(_ newScore: Int) -> Bool {
        var valid = false
        let scores = getAll().map { $0.score }

        if newScore <= 0 {
            return false
        }

        if scores.isEmpty {
            return true
        }

        scores.forEach {
            if newScore > $0 {
                valid = true
            }
        }

        return valid
    }

    static func removeLowest() {
        let users = getAll()

        if users.count <= 4 {
            return
        }

        var target = users.first!

        users.forEach { user in
            if user.score < target.score {
                target = user
            }
        }

        remove(target.id)
    }
}
