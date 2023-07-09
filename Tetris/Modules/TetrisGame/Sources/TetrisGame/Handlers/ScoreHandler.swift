import Foundation

struct User {
    let id: String = UUID().uuidString
    let name: String
    let score: Int
}

enum ScoreHandler {
    static func save(_ user: User) {
        let value: [String: Int] = [user.name: user.score]
        UserDefaults.standard.set(value, forKey: user.id)
    }

    static func remove(_ id: String) {
        UserDefaults.standard.removeObject(forKey: id)
    }

    static func getAll() -> [User] {
        var list = [User]()

        for (_, value) in UserDefaults.standard.dictionaryRepresentation() {
            guard let hash = value as? [String: Int] else { continue }
            let user = User(name: hash.keys.first!, score: hash.values.first!)
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

        if users.count <= 5 {
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
