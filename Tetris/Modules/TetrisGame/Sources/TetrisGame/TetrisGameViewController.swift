import UIKit
import ViewCode

public final class TetrisGameViewController: UIViewController {

    private lazy var shapeB: ShapeB = ShapeB(.green)
    
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
        boardView.size(height: 640, width: 326)
        
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

        boardView.addSubview(shapeB)

        shapeB.frame = CGRect(
            x: boardView.bounds.midX,
            y: boardView.bounds.midY,
            width: shapeB.absWidth(),
            height: shapeB.absHeight()
        )

        //shapeB.centerXYEqual(to: boardView)

        Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(drop), userInfo: nil, repeats: true)
    }

    @objc func tapLeft() {
        moveHorizontal(shape: shapeB, side: .left)
    }

    @objc func tapDown() {
        //
    }

    @objc func tapRight() {
        moveHorizontal(shape: shapeB, side: .right)
    }
    
    @objc func rotateLeft() {
        shapeB.rotateLeft()
    }
    
    @objc func rotateRight() {
        shapeB.rotateRight()
    }

    private func moveHorizontal(shape: TetrisShape, side: MoveSide) {
        let shapeValidWidth = shape.absWidth()
        let shapeBufferX = shape.frame.midX
        let shapeBufferY = shape.frame.midY
        let shapeBufferWidth = shape.frame.width

        var move = CUBE_SIZE

        if side == .left {
            move *= -1
        }

        print("shapeValidWith => \(shapeValidWidth)")

        print("shapeBufferWidth => \(shapeBufferWidth)")
        print("shapeBufferX => \(shapeBufferX)")
        print("shapeBufferY => \(shapeBufferY)")

        let newX = shapeBufferX + move

        // WIP collision
        if side == .left && newX < boardView.frame.minX {
            return
        } else if side == .right && newX > boardView.frame.maxX - (2 * CUBE_SIZE) {
            return
        }

        print("newX => \(newX)")

        print("===========")

        animateMove(shape, from: shapeBufferX, to: newX, orientation: .horizontal)
    }

    @objc private func drop() {
//        let realValue: CGFloat = -25
//        let originalY = shape.frame.midY
//        let newYPosition = originalY - realValue
//
//        // colision
//
//        if newYPosition >= 640 {
//            return
//        }
//
//        animateMove(shape, from: originalY, to: newYPosition, orientation: .vertical)
    }

    private func animateMove(_ shape: TetrisShape, from: CGFloat, to: CGFloat, orientation: MoveOrientation) {
        let animaiton = CABasicAnimation()
        animaiton.keyPath = orientation == .horizontal ? "position.x" : "position.y"
        animaiton.fromValue = from
        animaiton.toValue = to
        animaiton.duration = 0.05

        shape.layer.add(animaiton, forKey: "basic")

        if orientation == .horizontal {
            shape.layer.position = CGPoint(x: to, y: shape.frame.midY)
        } else {
            shape.layer.position = CGPoint(x: shape.frame.midX, y: to)
        }
    }
}

enum MoveOrientation {
    case horizontal, vertical
}

enum MoveSide {
    case left, right
}