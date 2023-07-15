import UIKit
import ViewCode

public final class TetrisGameViewController: UIViewController {

    private var model: TetrisViewModel?

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

    required init?(coder: NSCoder) {
        return nil
    }

    init(_ viewModel: TetrisViewModel) {
        self.model = viewModel
        super.init(nibName: nil, bundle: nil)
        model?.setController(self)
    }

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

        bind()
        setListeners()
    }

    @objc private func tapScreen() {
        model?.showMenu()
    }

    @objc private func startNewGame() {
        model?.startNewGame()
    }

    @objc private func showDifficultyMenu() {
        model?.showDifficultyMenu()
    }

    @objc private func showStats() {
        model?.showStats()
    }

    @objc private func acceptDifficulty() {
        model?.startNewGame()
    }

    @objc private func increaseDifficulty() {
        model?.increaseDifficulty()
    }

    @objc private func decreaseDifficulty() {
        model?.decreaseDifficulty()
    }

    @objc private func dismissScoreSave() {
        model?.dismissScoreSave()
    }

    @objc private func tapLeft() {
        model?.moveLeft()
    }

    @objc private func tapRight() {
        model?.moveRight()
    }
    
    @objc private func rotateLeft() {
        model?.rotateLeft()
    }
    
    @objc private func rotateRight() {
        model?.rotateRight()
    }

    @objc private func tapDown() {
        model?.drop()
    }

    func render() {
        guard let matrix = model?.currentBoard() else { return }

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

    func animate(rows: [Int]) {
        let animatedRow = UIView()
        animatedRow.size(height: CUBE_SIZE, width: boardView.frame.width)
        self.view.addSubview(animatedRow)
        animatedRow.anchor(bottom: boardView.bottomAnchor, leading: boardView.leadingAnchor)
        animatedRow.backgroundColor = .white

        UIView.animate(withDuration: 0.02, delay: 0, options: [.autoreverse], animations: {
            animatedRow.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.05, delay: 0.2, options: .curveEaseInOut, animations: {
                animatedRow.alpha = 0.0
            }) { _ in
                animatedRow.removeFromSuperview()
            }
        }
    }

    private func bind() {
        model?.difficultyMenuHidden.bind { [weak self] in
            self?.difficultyMenu.isHidden = $0
        }

        model?.scoreBoardHidden.bind { [weak self] in
            self?.scoreBoard.isHidden = $0
        }

        model?.saveScoreViewHidden.bind { [weak self] in
            self?.saveScoreView.isHidden = $0
        }

        model?.mainMenuHidden.bind { [weak self] in
            self?.menu.isHidden = $0
        }

        model?.viewEndEditing.bind { [weak self] in
            self?.view.endEditing($0)
        }

        model?.difficultyLabel.bind { [weak self] in
            self?.difficultyMenu.setDifficultyLabel($0)
        }

        model?.currentScore.bind { [weak self] in
            self?.header.setPointsLabel($0)
            self?.saveScoreView.setScore($0)
        }

        model?.controlButtonsEnabled.bind { [weak self] in
            self?.controlPanel.setButtonsEnabled($0)
        }

        model?.boardUsersScore.bind { [weak self] in
            self?.scoreBoard.setScore($0)
        }

        model?.nextShape.bind { [weak self] in
            self?.header.setNextShape($0)
        }
    }

    private func setListeners() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        self.view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(showDifficultyMenu), name: .showDifficultyMenu, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startNewGame), name: .startNewGame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showStats), name: .showStats, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(acceptDifficulty), name: .acceptDifficulty, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(increaseDifficulty), name: .increaseDifficulty, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(decreaseDifficulty), name: .decreaseDifficulty, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(tapDown), name: .tapDown, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tapRight), name: .tapRight, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tapLeft), name: .tapLeft, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rotateLeft), name: .rotateLeft, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rotateRight), name: .rotateRight, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(dismissScoreSave), name: .savedScore, object: nil)
    }
}
