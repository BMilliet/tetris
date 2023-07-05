import Foundation

public final class ShapeE: ShapeProtocol, CustomStringConvertible {

    private var currentPosition: Int
    private let color: Int
    private var x = 0
    private var y = 0

    private lazy var matrix: [[[Int]]] = [
            [
                [0,color,0],
                [0,color,0],
                [color,color,0]
            ],

            [
                [color,0,0],
                [color,color,color],
                [0,0,0]
            ],

            [
                [0,color,color],
                [0,color,0],
                [0,color,0]
            ],

            [
                [0,0,0],
                [color,color,color],
                [0,0,color]
            ]
        ]

    public var description: String {
        let pos = "position: \(currentPosition)"
        let x = "x: \(x)"
        let y = "y: \(y)"

        return [pos, x, y].joined(separator: "\n")
    }

    init() {
        let x = SHAPE_POS.first!
        let y = SHAPE_POS.last!
        currentPosition = Int(arc4random_uniform(4))
        color = Int(arc4random_uniform(8))
        setCoordinates(x, y)
    }

    public func copy() -> ShapeProtocol {
        let copy = ShapeE()
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
        currentPosition += 1

        if currentPosition >= 4 {
            currentPosition = 0
        }
    }

    public func rotateRight() {
        currentPosition -= 1

        if currentPosition < 0 {
            currentPosition = 3
        }
    }

    public func setCoordinates(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}
