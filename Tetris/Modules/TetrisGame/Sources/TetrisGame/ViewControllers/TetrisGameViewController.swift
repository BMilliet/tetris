import UIKit
import ViewCode

public final class TetrisGameViewController: UIViewController {

    private var board = Board()
    private var timer: Timer?
    private var difficultyLevel = 0.2
    private var difficultyNumber = 2

    private lazy var boardView: UIView = {
        let board = UIView()
        board.backgroundColor = .gray
        return board
    }()

    private lazy var boardContainer: UIView = {
        let board = UIView()
        board.backgroundColor = .black
        return board
    }()

    private lazy var stack: UIStackView = {
        let st = UIStackView()
        st.axis = .vertical
        return st
    }()

    private lazy var spacer: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    private lazy var header: HeaderView = HeaderView()
    private lazy var menu: MenuView = MenuView()
    private lazy var controlPanel: ControlPanelView = ControlPanelView()
    private lazy var difficultyMenu: DifficultyMenuView = DifficultyMenuView()
    private lazy var saveScoreView: SaveScoreView = SaveScoreView()
    private lazy var scoreBoard: ScoreBoard = ScoreBoard()

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.view.addSubview(stack)

        stack.setAnchorsEqual(to: self.view)
        stack.addArrangedSubview(header)
        stack.addArrangedSubview(boardContainer)
        stack.addArrangedSubview(spacer)
        stack.addArrangedSubview(controlPanel)

        boardContainer.addSubview(boardView)
        boardView.centerXEqual(to: boardContainer)
        boardView.anchor(top: boardContainer.topAnchor, bottom: boardContainer.bottomAnchor, paddingTop: 4, paddingBottom: 4)
        boardView.size(height: BOARDVIEW_HEIGHT, width: BOARDVIEW_WIDTH)

        self.view.addSubview(menu)
        self.view.addSubview(difficultyMenu)
        self.view.addSubview(saveScoreView)
        self.view.addSubview(scoreBoard)

        saveScoreView.isHidden = true
        scoreBoard.isHidden = true

        menu.centerXYEqual(to: view)
        difficultyMenu.centerXYEqual(to: view)
        saveScoreView.centerXYEqual(to: view)
        scoreBoard.centerXYEqual(to: view)

        areButtons(enabled: false)

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        self.view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(showDifficultyMenu), name: .showDifficultyMenu, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startNewGame), name: .startNewGame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showStats), name: .showStats, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(acceptDifficulty), name: .acceptDifficulty, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(increaseDifficulty), name: .increaseDifficulty, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dicreaseDifficulty), name: .dicreaseDifficulty, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(tapDown), name: .tapDown, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tapRight), name: .tapRight, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tapLeft), name: .tapLeft, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rotateLeft), name: .rotateLeft, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rotateRight), name: .rotateRight, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(dismissScoreSave), name: .savedScore, object: nil)
    }

    @objc private func tapScreen() {
        if !scoreBoard.isHidden || !saveScoreView.isHidden || !difficultyMenu.isHidden {
            saveScoreView.isHidden = true
            scoreBoard.isHidden = true
            difficultyMenu.isHidden = true
            menu.isHidden = false
        }
    }

    @objc private func startNewGame() {
        menu.isHidden = true
        areButtons(enabled: true)
        board = Board()
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: difficultyLevel, target: self, selector: #selector(drop), userInfo: nil, repeats: true)
    }

    @objc private func showDifficultyMenu() {
        setDifficultyLevel()
        difficultyMenu.isHidden = false
        menu.isHidden = true
    }

    @objc private func showStats() {
        menu.isHidden = true
        scoreBoard.isHidden = false
        scoreBoard.setScore(ScoreHandler.getAll())
    }

    @objc private func acceptDifficulty() {
        difficultyMenu.isHidden = true
        menu.isHidden = false
    }

    @objc private func increaseDifficulty() {
        if difficultyNumber < 4 {
            difficultyNumber += 1
        }
        setDifficultyLevel()
    }

    @objc private func dicreaseDifficulty() {
        if difficultyNumber > 0 {
            difficultyNumber -= 1
        }
        setDifficultyLevel()
    }

    @objc private func tapLeft() {
        board.moveLeft(1)
        render()
    }

    @objc private func tapDown() {
        board.drop()
        render()
        checkGameStatus()
        header.setNextShape(board.getNextShapeMatrix())
    }

    @objc private func tapRight() {
        board.moveRight(1)
        render()
    }
    
    @objc private func rotateLeft() {
        board.rotateLeft()
        render()
    }
    
    @objc private func rotateRight() {
        board.rotateRight()
        render()
    }

    @objc private func drop() {
        board.moveDown()
        render()
        checkGameStatus()
        header.setNextShape(board.getNextShapeMatrix())
    }

    @objc private func dismissScoreSave() {
        saveScoreView.isHidden = true
        menu.isHidden = false
    }

    private func checkGameStatus() {
        if !board.gameOver {
            return
        }

        timer?.invalidate()
        areButtons(enabled: false)

        if ScoreHandler.isScoreInTop(board.getPoints()) {
            saveScoreView.setScore(board.getPoints())
            saveScoreView.isHidden = false
        } else {
            menu.isHidden = false
        }
    }

    private func areButtons(enabled: Bool) {
        controlPanel.setButtonsEnabled(enabled)
    }

    private func render() {
        header.setPointsLabel(board.getPoints())

        let matrix = board.getMatrix()

        boardView.subviews.forEach { $0.removeFromSuperview() }

        for (ir, row) in matrix.enumerated() {
            for (ic, column) in row.enumerated() {
                if column != 0 {
                    let x = CGFloat(ic) * CUBE_SIZE
                    let y = CGFloat(ir) * CUBE_SIZE

                    let newCube = Cube(color: Colors.get(column))

                    boardView.addSubview(newCube)
                    newCube.frame = CGRect(x: x, y: y, width: CUBE_SIZE, height: CUBE_SIZE)
                }
            }
        }
    }

    private func setDifficultyLevel() {
        switch difficultyNumber {
        case 0:
            difficultyMenu.setDifficultyLabel("very easy")
            difficultyLevel = 1.0
        case 1:
            difficultyMenu.setDifficultyLabel("easy")
            difficultyLevel = 0.8
        case 2:
            difficultyMenu.setDifficultyLabel("normal")
            difficultyLevel = 0.6
        case 3:
            difficultyMenu.setDifficultyLabel("hard")
            difficultyLevel = 0.4
        case 4:
            difficultyMenu.setDifficultyLabel("very hard")
            difficultyLevel = 0.2
        default:
            difficultyLevel = 0.6
        }
    }
}
