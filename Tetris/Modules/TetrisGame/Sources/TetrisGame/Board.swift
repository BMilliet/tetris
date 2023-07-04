import UIKit

public final class Board {
    
    private var matrix = [[Int]]()
    private var selectedShape = ShapeA()

    private let COLUMNS = 13
    private let ROWS = 25

    init() {
        drawMatrix()
        selectedShape.setCoordinates(4, 16)
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

    func moveLeft() {
        let shape = selectedShape
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]

        let newX = x - 1

//        if newX - shape.leftCollision() + shape.current().first!.count < 0 {
//            printAsTable()
//            return
//        }

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

        var line = ""
        print("===========================")

        matrix.forEach { row in
            row.forEach {
                line += "\($0) "
            }
            print(line)
            line = ""
        }
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
}

public final class ShapeA: Shape {
    
    private var currentPosition = Int(arc4random_uniform(4))
    private var x = 0
    private var y = 0

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
