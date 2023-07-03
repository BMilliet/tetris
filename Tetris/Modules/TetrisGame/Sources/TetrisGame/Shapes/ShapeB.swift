import UIKit

public final class ShapeB: UIView, TetrisShape {

    private var currentPosition = Int(arc4random_uniform(4))
    private let color: UIColor

    private let matrix = [
        [
            [0,0,0],
            [1,1,1],
            [0,1,0]
        ],

        [
            [0,1,0],
            [1,1,0],
            [0,1,0]
        ],

        [
            [0,1,0],
            [1,1,1],
            [0,0,0]
        ],

        [
            [0,1,0],
            [0,1,1],
            [0,1,0]
        ]
    ]

    private lazy var stackV: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    private lazy var row1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()

    private lazy var row2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()

    private lazy var row3: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()

    required init?(coder: NSCoder) { return nil }
    public init(_ color: UIColor) {
        self.color = color
        super.init(frame: .zero)

        self.addSubviews([stackV])
        stackV.setAnchorsEqual(to: self)
        stackV.addArrangedSubview(row1)
        stackV.addArrangedSubview(row2)
        stackV.addArrangedSubview(row3)

        render()
    }

    func render() {
        let currentMatrix = matrix[currentPosition]

        currentMatrix[2].forEach {
            if $0 == 1 {
                row3.addArrangedSubview(Cube(color: color))
            } else {
                row3.addArrangedSubview(Cube(color: .clear))
            }
        }

        currentMatrix[1].forEach {
            if $0 == 1 {
                row2.addArrangedSubview(Cube(color: color))
            } else {
                row2.addArrangedSubview(Cube(color: .clear))
            }
        }

        currentMatrix[0].forEach {
            if $0 == 1 {
                row1.addArrangedSubview(Cube(color: color))
            } else {
                row1.addArrangedSubview(Cube(color: .clear))
            }
        }
    }

    func rotateLeft() {
        clearAll()
        currentPosition += 1

        if currentPosition >= 4 {
            currentPosition = 0
        }

        render()
    }

    func rotateRight() {
        clearAll()
        currentPosition -= 1

        if currentPosition < 0 {
            currentPosition = 3
        }

        render()
    }

    public func getMatrix() -> [[Int]] {
        return matrix[currentPosition]
    }

    public func absWidth() -> CGFloat {
        return CGFloat(matrix.first!.first!.count * Int(CUBE_SIZE))
    }

    public func absHeight() -> CGFloat {
        return CGFloat(matrix.first!.count * Int(CUBE_SIZE))
    }

    public func collisionWidth() -> CGFloat {
        let currentMatrix = matrix[currentPosition]
        var len = [Int]()

        currentMatrix.forEach { row in
            len.append(row.reduce(0, { return $0 + $1 }))
        }

        return CGFloat(len.max()! * Int(CUBE_SIZE))
    }

    public func collisionHeight() -> CGFloat {
        let currentMatrix = matrix[currentPosition]
        var len = [Int]()

        len.append(currentMatrix[0][0] + currentMatrix[1][0] + currentMatrix[2][0])
        len.append(currentMatrix[0][1] + currentMatrix[1][1] + currentMatrix[2][1])
        len.append(currentMatrix[0][2] + currentMatrix[1][2] + currentMatrix[2][2])

        return CGFloat(len.max()! * Int(CUBE_SIZE))
    }

    public func leftCollision() -> CGFloat {
        let currentMatrix = matrix[currentPosition]

        if currentMatrix[0][0] == 0 && currentMatrix[1][0] == 0 && currentMatrix[2][0] == 0 {
            return -CUBE_SIZE
        } else {
            return 0
        }
    }

    public func rightCollision() -> CGFloat {
        let currentMatrix = matrix[currentPosition]

        if currentMatrix[0][2] == 0 && currentMatrix[1][2] == 0 && currentMatrix[2][2] == 0 {
            return -CUBE_SIZE
        } else {
            return -2 * CUBE_SIZE
        }
    }

    public func downCollision() -> CGFloat {
        return 0
    }

    private func clearAll() {
        row1.subviews.forEach { $0.removeFromSuperview() }
        row2.subviews.forEach { $0.removeFromSuperview() }
        row3.subviews.forEach { $0.removeFromSuperview() }
    }
}
