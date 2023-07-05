import UIKit
import ViewCode

public final class TetrisGameViewController: UIViewController {

    private let board = Board()

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
        label.text = "0"
        return label
    }()
    
    private lazy var controlPanel: UIView = {
        let panel = UIView()
        panel.backgroundColor = .blue
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

        pointsLabel.anchor(bottom: controlPanel.topAnchor, paddingBottom: 8)
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

        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(drop), userInfo: nil, repeats: true)
    }

    @objc func tapLeft() {
        board.moveLeft(1)
        render()
    }

    @objc func tapDown() {
        board.moveDown()
        render()
    }

    @objc func tapRight() {
        board.moveRight(1)
        render()
    }
    
    @objc func rotateLeft() {
        board.rotateLeft()
        render()
    }
    
    @objc func rotateRight() {
        board.rotateRight()
        render()
    }

    @objc private func drop() {
        board.moveDown()
        render()
    }

    private func render() {
        board.removeRowIfPossible()
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
