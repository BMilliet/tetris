import Foundation

public final class ShapeD: ShapeProtocol, CustomStringConvertible {

    private var currentPosition: Int
    private let color: Int
    private var x = 0
    private var y = 0

    private lazy var matrix: [[[Int]]] = [
            [
                [0,color,0],
                [0,color,0],
                [0,color,color]
            ],

            [
                [0,0,color],
                [color,color,color],
                [0,0,0]
            ],

            [
                [color,color,0],
                [0,color,0],
                [0,color,0]
            ],

            [
                [0,0,0],
                [color,color,color],
                [color,0,0]
            ]
        ]

    public var description: String {
        let pos = "position: \(currentPosition)"
        let x = "x: \(x)"
        let y = "y: \(y)"

        ShapeUtils.printAsTable(matrix[currentPosition])
        return [pos, x, y].joined(separator: "\n")
    }

    init(currentPosition: Int = Int(arc4random_uniform(4)), color: Int = Int(arc4random_uniform(8)) + 1) {
        let x = SHAPE_POS.first!
        let y = SHAPE_POS.last!
        self.currentPosition = currentPosition
        self.color = color
        setCoordinates(x, y)
    }

    public func copy() -> ShapeProtocol {
        let copy = ShapeD()
        copy.x = self.x
        copy.y = self.y
        copy.setPosition(self.currentPosition)
        return copy
    }

    public func setPosition(_ int: Int) {
        self.currentPosition = int
    }

    public func current() -> [[Int]] {
        return matrix[currentPosition]
    }

    public func coordinates() -> [Int] {
        return [x, y]
    }

    public func rotateLeft() {
        currentPosition = RotationHandler
            .rotate(sides: matrix.count,
                    current: currentPosition,
                    orientation: .left)
    }

    public func rotateRight() {
        currentPosition = RotationHandler
            .rotate(sides: matrix.count,
                    current: currentPosition,
                    orientation: .right)
    }

    public func setCoordinates(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}
