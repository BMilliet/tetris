import Foundation

final class TetrisViewModel {

    private var board = Board()
    private var timer: Timer?
    private var difficultyLevel = 0.2
    private var difficultyNumber = 2

    var viewEndEditing: Bindable<Bool> = Bindable(true)

    var controlButtonsEnabled: Bindable<Bool> = Bindable(false)
    var difficultyMenuHidden: Bindable<Bool> = Bindable(true)
    var saveScoreViewHidden: Bindable<Bool> = Bindable(true)
    var scoreBoardHidden: Bindable<Bool> = Bindable(true)
    var mainMenuHidden: Bindable<Bool> = Bindable(false)

    var difficultyLabel: Bindable<String> = Bindable("")
    var currentScore: Bindable<Int> = Bindable(0)
    var boardUsersScore: Bindable<[User]> = Bindable([])
    var nextShape: Bindable<[[Int]]> = Bindable([[]])

    func showMenu() {
        if board.gameOver {
            hideAllViews()
            mainMenuHidden.value = false
        }
    }

    func showDifficultyMenu() {
        setDifficultyLevel()
        hideAllViews()
        difficultyMenuHidden.value = false
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
        difficultyMenuHidden.value = true
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

    func increaseDifficulty() {
        if difficultyNumber < 5 {
            difficultyNumber += 1
        }
        setDifficultyLevel()
    }

    func decreaseDifficulty() {
        if difficultyNumber > 0 {
            difficultyNumber -= 1
        }
        setDifficultyLevel()
    }

    @objc private func moveDown() {
        board.moveDown()
        renderGame()
        checkGameStatus()
        nextShape.value = board.getNextShapeMatrix()
    }

    private func checkGameStatus() {

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
        NotificationCenter.default.post(name: .render, object: nil)
    }

    private func setDifficultyLevel() {
        switch difficultyNumber {
        case 0:
            difficultyLabel.value = "very easy"
            difficultyLevel = 0.8
        case 1:
            difficultyLabel.value = "easy"
            difficultyLevel = 0.6
        case 2:
            difficultyLabel.value = "normal"
            difficultyLevel = 0.4
        case 3:
            difficultyLabel.value = "hard"
            difficultyLevel = 0.2
        case 4:
            difficultyLabel.value = "very hard"
            difficultyLevel = 0.1
        case 5:
            difficultyLabel.value = "legendary"
            difficultyLevel = 0.05
        default:
            difficultyLevel = 0.4
        }
    }
}

extension Notification.Name {
    static let render = Notification.Name("render")
}
