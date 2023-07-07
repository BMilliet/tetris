import Foundation

public final class ShapeC: ShapeProtocol, CustomStringConvertible {

    private var currentPosition: Int = 0
    private let color: Int
    private var x = 0
    private var y = 0

    private lazy var matrix: [[[Int]]] = [
            [
                [color,color],
                [color,color]
            ]
        ]

    public var description: String {
        let pos = "position: \(currentPosition)"
        let x = "x: \(x)"
        let y = "y: \(y)"

        ShapeUtils.printAsTable(matrix[currentPosition])
        return [pos, x, y].joined(separator: "\n")
    }

    init(color: Int = Int(arc4random_uniform(8)) + 1) {
        let x = SHAPE_POS.first!
        let y = SHAPE_POS.last!
        self.color = Int(arc4random_uniform(8))
        setCoordinates(x, y)
    }

    public func copy() -> ShapeProtocol {
        let copy = ShapeC()
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

    public func rotateLeft() {}

    public func rotateRight() {}

    public func setCoordinates(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}
