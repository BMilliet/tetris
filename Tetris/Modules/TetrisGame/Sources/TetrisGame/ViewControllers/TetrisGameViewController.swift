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
    
    private lazy var arena: UIView = {
        let board = UIView()
        board.backgroundColor = .black
        return board
    }()

    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        label.text = "0"
        return label
    }()
    
    private lazy var controlPanel: UIView = {
        let panel = UIView()
        panel.backgroundColor = .lightGray
        panel.size(height: 100)
        return panel
    }()
    
    private lazy var buttonDown: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.size(height: 50, width: 50)
        button.setImage(UIImage(systemName: "arrow.down")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapDown), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonRight: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.size(height: 50, width: 50)
        button.setImage(UIImage(systemName: "arrow.right")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapRight), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonLeft: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.size(height: 50, width: 50)
        button.setImage(UIImage(systemName: "arrow.left")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapLeft), for: .touchUpInside)
        return button
    }()
    
    private lazy var rotateLeftButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.size(height: 50, width: 50)
        button.setImage(UIImage(systemName: "arrow.uturn.right")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(rotateLeft), for: .touchUpInside)
        return button
    }()
    
    private lazy var rotateRightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.size(height: 50, width: 50)
        button.setImage(UIImage(systemName: "arrow.uturn.left")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(rotateRight), for: .touchUpInside)
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let st = UIStackView()
        st.axis = .vertical
        return st
    }()

    private lazy var menu: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.layer.cornerRadius = 10
        stack.spacing = 10
        return stack
    }()

    private lazy var newGameButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(startNewGame), for: .touchUpInside)
        return button
    }()

    private lazy var difficultyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setTitle("Difficulty", for: .normal)
        button.addTarget(self, action: #selector(showDifficultyMenu), for: .touchUpInside)
        return button
    }()

    private lazy var statsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setTitle("Stats", for: .normal)
        button.addTarget(self, action: #selector(startNewGame), for: .touchUpInside)
        return button
    }()

    private lazy var difficultyPicker: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .lightGray
        stack.layer.cornerRadius = 10
        return stack
    }()

    private lazy var difficultyMenu: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.layer.cornerRadius = 10
        stack.spacing = 8
        stack.isHidden = true
        return stack
    }()

    private lazy var acceptDifficultyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setTitle("OK", for: .normal)
        button.addTarget(self, action: #selector(acceptDifficulty), for: .touchUpInside)
        return button
    }()

    private lazy var increaseDifficultyButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "arrow.right")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(increaseDifficulty), for: .touchUpInside)
        return button
    }()

    private lazy var dicreaseDifficultyButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "arrow.left")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dicreaseDifficulty), for: .touchUpInside)
        return button
    }()

    private lazy var difficultyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        label.text = ""
        return label
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(stack)
        
        stack.setAnchorsEqual(to: self.view)
        stack.addArrangedSubview(arena)
        stack.addArrangedSubview(controlPanel)
        
        arena.addSubview(boardView)
        boardView.centerXYEqual(to: arena)
        boardView.size(height: BOARDVIEW_POS.last!, width: BOARDVIEW_POS.first!)
        
        controlPanel.addSubview(buttonLeft)
        controlPanel.addSubview(buttonDown)
        controlPanel.addSubview(buttonRight)
        controlPanel.addSubview(rotateLeftButton)
        controlPanel.addSubview(rotateRightButton)
        controlPanel.addSubview(pointsLabel)

        pointsLabel.anchor(bottom: controlPanel.topAnchor, paddingBottom: 4)
        pointsLabel.centerXEqual(to: controlPanel)
        pointsLabel.size(height: 60, width: 100)
        
        rotateLeftButton.centerYEqual(to: controlPanel)
        rotateRightButton.centerYEqual(to: controlPanel)
        
        rotateLeftButton.anchor(leading: controlPanel.leadingAnchor, paddingLeft: 10)
        rotateRightButton.anchor(trailing: controlPanel.trailingAnchor, paddingRight: 10)
        
        buttonDown.centerXYEqual(to: controlPanel)
        buttonLeft.centerYEqual(to: controlPanel)
        buttonRight.centerYEqual(to: controlPanel)
        
        buttonLeft.anchor(trailing: buttonDown.leadingAnchor, paddingRight: 10)
        buttonRight.anchor(leading: buttonDown.trailingAnchor, paddingLeft: 10)

        self.view.addSubview(menu)
        menu.addArrangedSubview(newGameButton)
        menu.addArrangedSubview(difficultyButton)
        menu.addArrangedSubview(statsButton)

        newGameButton.size(height: 50, width: UIScreen.main.bounds.size.width - 100)
        difficultyButton.size(height: 50, width: UIScreen.main.bounds.size.width - 100)
        statsButton.size(height: 50, width: UIScreen.main.bounds.size.width - 100)

        self.view.addSubview(difficultyMenu)
        difficultyMenu.addArrangedSubview(difficultyPicker)
        difficultyMenu.addArrangedSubview(acceptDifficultyButton)

        difficultyPicker.addArrangedSubview(dicreaseDifficultyButton)
        difficultyPicker.addArrangedSubview(difficultyLabel)
        difficultyPicker.addArrangedSubview(increaseDifficultyButton)

        dicreaseDifficultyButton.size(height: 50, width: 50)
        increaseDifficultyButton.size(height: 50, width: 50)
        difficultyLabel.size(height: 50, width: 140)
        acceptDifficultyButton.size(height: 50)

        menu.centerXYEqual(to: view)
        difficultyMenu.centerXYEqual(to: view)

        areButtons(enabled: false)
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
        board.moveDown()
        render()
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
    }

    private func stopGame() {
        timer?.invalidate()
        menu.isHidden = false
        areButtons(enabled: false)
    }

    private func setDifficultyLevel() {
        switch difficultyNumber {
        case 0:
            difficultyLabel.text = "very easy"
            difficultyLevel = 1.0
        case 1:
            difficultyLabel.text = "easy"
            difficultyLevel = 0.8
        case 2:
            difficultyLabel.text = "normal"
            difficultyLevel = 0.6
        case 3:
            difficultyLabel.text = "hard"
            difficultyLevel = 0.4
        case 4:
            difficultyLabel.text = "very hard"
            difficultyLevel = 0.2
        default:
            difficultyLabel.text = ""
        }
    }

    private func areButtons(enabled: Bool) {
        rotateLeftButton.isEnabled = enabled
        rotateRightButton.isEnabled = enabled
        buttonLeft.isEnabled = enabled
        buttonRight.isEnabled = enabled
        buttonDown.isEnabled = enabled
    }

    private func checkGameStatus() {
        if board.gameOver {
            stopGame()
        }
    }

    private func render() {
        pointsLabel.text = "\(board.getPoints())"

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
}
