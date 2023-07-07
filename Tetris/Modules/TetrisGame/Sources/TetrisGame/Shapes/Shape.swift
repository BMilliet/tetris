import Foundation

public final class Shape: ShapeProtocol, CustomStringConvertible {

    private var matrix = [[[Int]]]()
    private var currentPosition: Int
    private var x = 0
    private var y = 0

    init(matrix: [[[Int]]], position: Int? = nil, x: Int? = nil, y: Int? = nil) {
        self.matrix = matrix
        self.currentPosition = position ?? Int(arc4random_uniform(UInt32(matrix.count)))
        self.x = x ?? SHAPE_DEFAULT_X
        self.y = y ?? SHAPE_DEFAULT_Y
    }

    init(matrixNumber: Int? = nil, position: Int? = nil, x: Int? = nil, y: Int? = nil) {
        self.matrix = MatrixFactory.create(matrixNumber)
        self.currentPosition = position ?? Int(arc4random_uniform(UInt32(matrix.count)))
        self.x = x ?? SHAPE_DEFAULT_X
        self.y = y ?? SHAPE_DEFAULT_Y
    }

    public func current() -> [[Int]] {
        return matrix[currentPosition]
    }

    public func coordinates() -> [Int] {
        return [x, y]
    }

    public func setCoordinates(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
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

    public func copy() -> ShapeProtocol {
        return Shape(
            matrix: self.matrix,
            position: self.currentPosition,
            x: self.x,
            y: self.y
        )
    }

    public func setPosition(_ int: Int) {
        self.currentPosition = int
    }

    public var description: String {
        let pos = "position: \(currentPosition)"
        let x = "x: \(x)"
        let y = "y: \(y)"

        MatrixUtils.printAsTable(matrix[currentPosition])
        return [pos, x, y].joined(separator: "\n")
    }
}
