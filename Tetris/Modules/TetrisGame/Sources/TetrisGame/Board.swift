import UIKit

public final class Board {
    
    private var matrix = [[Int]]()
    private var selectedShape = ShapeA()

    private let COLUMNS = 13
    private let ROWS = 26

    init() {
        drawMatrix()
        selectedShape.setCoordinates(5, -1)
    }

    private func createNewShape() {

    }

    func getMatrix() -> [[Int]] {
        return matrix
    }

    private func merge(_ shape: Shape) {
        let shapeMatrix = shape.current()
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]

        for (ir, row) in shapeMatrix.enumerated() {
            for (ic, column) in row.enumerated() {
                if column != 0 {

                    let newX = ic + x
                    let newY = ir + y

                    if newX >= 0 && newY >= 0 && newX <= COLUMNS-1 && newY <= ROWS-1 {
                        matrix[newY][newX] = column
                    }
                }
            }
        }
    }

    func remove(_ shape: Shape) {
        let shapeMatrix = shape.current()
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]

        for (ir, row) in shapeMatrix.enumerated() {
            for (ic, column) in row.enumerated() {
                if column != 0 {

                    let newX = ic + x
                    let newY = ir + y

                    if newX >= 0 && newY >= 0 && newX <= COLUMNS-1 && newY <= ROWS-1 {
                        matrix[newY][newX] = 0
                    }
                }
            }
        }
    }

    func collide(_ shape: Shape) -> Bool {
        let shapeMatrix = shape.current()
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]

        print(shape)

        for (ir, row) in shapeMatrix.enumerated() {
            for (ic, column) in row.enumerated() {

                let newX = ic + x
                let newY = ir + y

                // collide left wall
                if newX < 0 && column != 0 {
                    return true
                }

                // collide right wall
                if newX >= COLUMNS-1 && column != 0 {
                    return true
                }

                // collide down
                if newY >= ROWS-1 && column != 0 {
                    return true
                }
            }
        }

        return false
    }

    func moveLeft() {
        let shape = selectedShape
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]

        let newX = x - 1

//        if newX - shape.leftCollision() + shape.current().first!.count < 0 {
//            printAsTable()
//            return
//        }

        let copy = shape.copy()
        copy.setCoordinates(newX, y)

        if collide(copy) {
            return
        }

        remove(shape)
        shape.setCoordinates(newX, y)
        merge(shape)
        printAsTable()
    }

    func moveRight() {
        let shape = selectedShape
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]

        let newX = x + 1

//        if newX + shape.rightCollision() > COLUMNS {
//            printAsTable()
//            return
//        }

        if collide(shape) {
            return
        }

        remove(shape)

        shape.setCoordinates(newX, y)
        merge(shape)

        printAsTable()
    }

    func moveDown() {
        let shape = selectedShape
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]

        let newY = y + 1

        if collide(shape) {
            return
        }

        remove(shape)

        shape.setCoordinates(x, newY)
        merge(shape)


        printAsTable()
    }

    func rotateLeft() {
        let shape = selectedShape
        remove(shape)
        selectedShape.rotateLeft()
        merge(shape)

        printAsTable()
    }

    func rotateRight() {
        let shape = selectedShape
        remove(shape)
        selectedShape.rotateRight()
        merge(shape)

        printAsTable()
    }

    private func drawMatrix() {
        let rows    = ROWS
        let columns = COLUMNS

        for _ in 0..<rows {
            var row = [Int]()

            for _ in 0..<columns {
                row.append(0)
            }

            matrix.append(row)
        }
    }

    private func printAsTable() {

//        var line = ""
//        print("===========================")
//
//        matrix.forEach { row in
//            row.forEach {
//                line += "\($0) "
//            }
//            print(line)
//            line = ""
//        }
    }

    func exec(_ x: Int, _ y: Int) {
        //merge(x, y)
        printAsTable()
    }

    private func drop() {

    }
}

public protocol Shape {
    func current() -> [[Int]]
    func coordinates() -> [Int]
    func setCoordinates(_ x: Int, _ y: Int)
    func rotateLeft()
    func rotateRight()
    func rightCollision() -> Int
    func leftCollision() -> Int
    func copy() -> Shape
    func setPosition(_ int: Int)
}

public final class ShapeA: Shape, CustomStringConvertible {

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

    }

    public func copy() -> Shape {
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

//public enum Utils {
//    public static func randomShape() -> Shape {
//
//    }
//}
