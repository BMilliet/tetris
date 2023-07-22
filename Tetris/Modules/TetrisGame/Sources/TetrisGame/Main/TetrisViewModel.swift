import Foundation

final class TetrisViewModel {

    private weak var viewController: TetrisGameViewController?

    private var board = Board(isGameOver: true)
    private var timer: Timer?
    private var difficultyLevel = 0.6

    var viewEndEditing: Bindable<Bool> = Bindable(true)

    var controlButtonsEnabled: Bindable<Bool> = Bindable(false)
    var saveScoreViewHidden: Bindable<Bool> = Bindable(true)
    var scoreBoardHidden: Bindable<Bool> = Bindable(true)
    var mainMenuHidden: Bindable<Bool> = Bindable(false)

    var currentScore: Bindable<Int> = Bindable(0)
    var boardUsersScore: Bindable<[User]> = Bindable([])
    var nextShape: Bindable<[[Int]]> = Bindable([[]])
    var currentEmoji: Bindable<String> = Bindable("")

    func setController(_ controller: TetrisGameViewController) {
        self.viewController = controller
    }

    func showMenu() {
        if board.gameOver {
            hideAllViews()
            mainMenuHidden.value = false
        }
    }

    func showStats() {
        hideAllViews()
        scoreBoardHidden.value = false
        boardUsersScore.value = ScoreHandler.getAll()
    }

    func showSaveScore() {
        hideAllViews()
        saveScoreViewHidden.value = false
        currentScore.value = board.getPoints()
    }

    func dismissScoreSave() {
        showMenu()
    }

    private func hideAllViews() {
        mainMenuHidden.value = true
        viewEndEditing.value = true
        scoreBoardHidden.value = true
        saveScoreViewHidden.value = true
    }

    func acceptDifficulty() {
        hideAllViews()
        startNewGame()
    }

    func startNewGame() {
        hideAllViews()
        board = Board()
        timer?.invalidate()
        controlButtonsEnabled.value = true
        timer = Timer.scheduledTimer(
            timeInterval: difficultyLevel, target: self,
            selector: #selector(moveDown), userInfo: nil, repeats: true
        )
    }

    func drop() {
        board.drop()
        renderGame()
        checkGameStatus()
        nextShape.value = board.getNextShapeMatrix()
    }

    func moveLeft() {
        board.moveLeft(1)
        renderGame()
    }

    func moveRight() {
        board.moveRight(1)
        renderGame()
    }

    func rotateLeft() {
        board.rotateLeft()
        renderGame()
    }

    func rotateRight() {
        board.rotateRight()
        renderGame()
    }

    func currentBoard() -> [[Int]] {
        return board.getMatrix()
    }

    @objc private func moveDown() {

        board.moveDown { [weak self] rows in
            guard let self = self else { return }
            self.timer?.invalidate()

            self.viewController?.animate(rows: rows, points: board.getPointsUp())

            self.timer = Timer.scheduledTimer(
                timeInterval: difficultyLevel, target: self,
                selector: #selector(moveDown), userInfo: nil, repeats: true)
        }

        renderGame()
        checkGameStatus()
        nextShape.value = board.getNextShapeMatrix()
    }

    var level1 = false
    var level2 = false
    var level3 = false
    var level4 = false
    var level5 = false
    var level6 = false

    private func increaseGameDifficulty() {
        let score = board.getPoints()

        if score >= 3000 && !level6 {
            level6 = true
            let emoji = "💀"
            currentEmoji.value = emoji
            viewController?.speedUpNotification(title: "bro u lose", emoji: emoji)
            difficultyLevel = 0.04
            return
        }

        if score >= 1000 && !level5 {
            level5 = true
            let emoji = "👿"
            currentEmoji.value = emoji
            viewController?.speedUpNotification(title: "keep going?", emoji: emoji)
            difficultyLevel = 0.06
            return
        }

        if score >= 800 && !level4 {
            level4 = true
            let emoji = "😡"
            currentEmoji.value = emoji
            viewController?.speedUpNotification(title: "LETS GO!!", emoji: emoji)
            difficultyLevel = 0.08
            return
        }

        if score >= 450 && !level3 {
            level3 = true
            let emoji = "😹"
            currentEmoji.value = emoji
            viewController?.speedUpNotification(title: "ok ok...", emoji: emoji)
            difficultyLevel = 0.1
            return
        }

        if score >= 300 && !level2 {
            level2 = true
            let emoji = "🍰"
            currentEmoji.value = emoji
            viewController?.speedUpNotification(title: "still easy...", emoji: emoji)
            difficultyLevel = 0.2
            return
        }

        if score >= 200 && !level1 {
            level1 = true
            let emoji = "😴"
            currentEmoji.value = emoji
            viewController?.speedUpNotification(title: "zzzZZZzzz..", emoji: emoji)
            difficultyLevel = 0.3
            return
        }

        if score >= 100 {
            difficultyLevel = 0.4
            return
        }
    }

    private func checkGameStatus() {

        increaseGameDifficulty()

        if !board.gameOver {
            return
        }

        timer?.invalidate()
        controlButtonsEnabled.value = false

        if ScoreHandler.isScoreInTop(board.getPoints()) {
            showSaveScore()
        } else {
            showMenu()
        }
    }

    private func renderGame() {
        currentScore.value = board.getPoints()
        viewController?.render()
    }
}
