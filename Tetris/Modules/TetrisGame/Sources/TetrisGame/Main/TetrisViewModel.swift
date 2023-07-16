import Foundation

final class TetrisViewModel {

    private weak var viewController: TetrisGameViewController?

    private var board = Board()
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

            rows.forEach {
                self.viewController?.animate(row: $0)
            }

            self.timer = Timer.scheduledTimer(
                timeInterval: difficultyLevel, target: self,
                selector: #selector(moveDown), userInfo: nil, repeats: true)
        }

        renderGame()
        checkGameStatus()
        nextShape.value = board.getNextShapeMatrix()
    }

    private func increaseGameDifficulty() {
        let score = board.getPoints()

        if score >= 6500 {
            difficultyLevel = 0.05
            return
        }

        if score >= 3200 {
            difficultyLevel = 0.1
            return
        }

        if score >= 1500 {
            difficultyLevel = 0.2
            return
        }

        if score >= 900 {
            difficultyLevel = 0.3
            return
        }

        if score >= 300 {
            difficultyLevel = 0.4
            return
        }

        if score >= 100 {
            difficultyLevel = 0.5
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
