import Foundation

public final class ShapeA: ShapeProtocol, CustomStringConvertible {

    private var currentPosition = Int(arc4random_uniform(4))
    private var x = 0
    private var y = 0

    public var description: String {
        let pos = "position: \(currentPosition)"
        let x = "x: \(x)"
        let y = "y: \(y)"

        return [pos, x, y].joined(separator: "\n")
    }

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

    init() {
        let x = SHAPE_POS.first!
        let y = SHAPE_POS.last!
        setCoordinates(x, y)
    }

    public func copy() -> ShapeProtocol {
        let copy = ShapeA()
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

    public func rightCollision() -> Int {
        var len = [Int]()

        let currentMatrix = matrix[currentPosition]


        currentMatrix.forEach { row in
            var l = 0

            for (i, x) in row.enumerated() {

                if x == 1 {
                    l = i+1
                }
            }

            len.append(l)
        }

        return len.max()!
    }

    public func leftCollision() -> Int {
        var len = [Int]()

        let currentMatrix = matrix[currentPosition]


        currentMatrix.forEach { row in
            var l = 0

            for (i, x) in row.reversed().enumerated() {

                if x == 1 {
                    l = i+1
                }
            }

            len.append(l)
        }

        return len.max()!
    }
}
