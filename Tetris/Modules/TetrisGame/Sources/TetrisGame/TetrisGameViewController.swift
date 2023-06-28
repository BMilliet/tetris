import UIKit
import ViewCode

public final class TetrisGameViewController: UIViewController {
    
//    private lazy var board: Board = Board(unit: 25, x: boardView.frame.width, y: boardView.frame.height)
    private lazy var shape: ShapeA = ShapeA(unit: 25)
    
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
    
    // MARK: CONTROLS
    
    private lazy var controlPanel: UIView = {
        let panel = UIView()
        panel.backgroundColor = .blue
        panel.size(height: 100)
        return panel
    }()
    
    private lazy var buttonDown: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.size(height: 50, width: 50)
        button.addTarget(self, action: #selector(tapDown), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonRight: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.size(height: 50, width: 50)
        button.addTarget(self, action: #selector(tapRight), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonLeft: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.size(height: 50, width: 50)
        button.addTarget(self, action: #selector(tapLeft), for: .touchUpInside)
        return button
    }()
    
    private lazy var rotateLeftButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.size(height: 50, width: 50)
        button.addTarget(self, action: #selector(rotateLeft), for: .touchUpInside)
        return button
    }()
    
    private lazy var rotateRightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.size(height: 50, width: 50)
        button.addTarget(self, action: #selector(rotateRight), for: .touchUpInside)
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let st = UIStackView()
        st.backgroundColor = .red
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
        boardView.size(height: 640, width: 340)
        
        controlPanel.addSubview(buttonLeft)
        controlPanel.addSubview(buttonDown)
        controlPanel.addSubview(buttonRight)
        controlPanel.addSubview(rotateLeftButton)
        controlPanel.addSubview(rotateRightButton)
        
        rotateLeftButton.centerYEqual(to: controlPanel)
        rotateRightButton.centerYEqual(to: controlPanel)
        
        rotateLeftButton.anchor(leading: controlPanel.leadingAnchor, paddingLeft: 10)
        rotateRightButton.anchor(trailing: controlPanel.trailingAnchor, paddingRight: 10)
        
        buttonDown.centerXYEqual(to: controlPanel)
        buttonLeft.centerYEqual(to: controlPanel)
        buttonRight.centerYEqual(to: controlPanel)
        
        buttonLeft.anchor(trailing: buttonDown.leadingAnchor, paddingRight: 10)
        buttonRight.anchor(leading: buttonDown.trailingAnchor, paddingLeft: 10)
        
        boardView.addSubview(shape)
        shape.centerXYEqual(to: boardView)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(drop), userInfo: nil, repeats: true)
    }

    @objc func tapLeft() {
        moveHorizontal(-20)
    }

    @objc func tapDown() {
        //
    }

    @objc func tapRight() {
        moveHorizontal(20)
    }
    
    @objc func rotateLeft() {
        let board = Board(x: boardView.frame.width, y: boardView.frame.height)
        shape.rotateLeft(board)
    }
    
    @objc func rotateRight() {
        let board = Board(x: boardView.frame.width, y: boardView.frame.height)
        shape.rotateRigth(board)
    }
    
    private func moveHorizontal(_ value: CGFloat) {
        var realValue = value
        
        // adjust proportion
        
        if value > 0 {
            realValue += shape.frame.width
        }
        
        var newXPosition = shape.frame.minX + realValue
        
        // colision
        
        if newXPosition > boardView.frame.width {
            newXPosition = boardView.frame.width - shape.frame.width + 50
        } else if newXPosition < 0 {
            newXPosition = 0 + shape.frame.width - 50
        }
        
        let animaiton = CABasicAnimation()
        animaiton.keyPath = "position.x"
        animaiton.fromValue = newXPosition
        animaiton.toValue = newXPosition
        animaiton.duration = 1
        
        shape.layer.add(animaiton, forKey: "basic")
        shape.layer.position = CGPoint(x: newXPosition, y: shape.frame.midY)
    }
    
    @objc private func drop() {
        let realValue: CGFloat = -100
        let newYPosition = shape.frame.minY - realValue
        
        // colision
        
        if newYPosition >= 640 {
            return
        }
        
        let animaiton = CABasicAnimation()
        animaiton.keyPath = "position.y"
        animaiton.fromValue = newYPosition
        animaiton.toValue = newYPosition
        animaiton.duration = 1
        
        shape.layer.add(animaiton, forKey: "basic")
        shape.layer.position = CGPoint(x: shape.frame.midX, y: newYPosition)
    }
}
