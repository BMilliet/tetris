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

    private func merge(_ x: Int, _ y: Int) {

        for (ir, row) in matrix.enumerated() {

            // found row
            if ir == y {

                for (ic, _) in row.enumerated() {

                    // found column
                    if ic == x {

                        let shape = selectedShape.current()

                        for (rowI, x) in shape.enumerated() {
                            for (columnI, y) in x.enumerated() {
                                if y != 0 {
                                    matrix[ir + rowI][ic + columnI] = y
                                }
                            }
                        }
                    }
                }
            }
        }

    }

    func remove(_ x: Int, _ y: Int) {

        for (ir, row) in matrix.enumerated() {

            // found row
            if ir == y {

                for (ic, _) in row.enumerated() {

                    // found column
                    // TODO: check if shape will fit
                    if ic == x {

                        let shape = selectedShape.current()

                        for (rowI, x) in shape.enumerated() {
                            for (columnI, y) in x.enumerated() {
                                if y != 0 {
                                    matrix[ir + rowI][ic + columnI] = 0
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    func moveLeft() {
        let x = selectedShape.coordinates()[0]
        let y = selectedShape.coordinates()[1]

        let newX = x - 1

        if newX < 0 {
            printAsTable()
            return
        }

        remove(x, y)
        merge(newX, y)

        selectedShape.setCoordinates(newX, y)

        printAsTable()
    }

    func moveRight() {
        let x = selectedShape.coordinates()[0]
        let y = selectedShape.coordinates()[1]

        let newX = x + 1

        if newX + selectedShape.leftCollision() > COLUMNS {
            printAsTable()
            return
        }

        remove(x, y)
        merge(newX, y)

        selectedShape.setCoordinates(newX, y)

        printAsTable()
    }

    func moveDown() {
        let x = selectedShape.coordinates()[0]
        let y = selectedShape.coordinates()[1]

        let newY = y + 1

        remove(x, y)
        merge(x, newY)

        selectedShape.setCoordinates(x, newY)

        printAsTable()
    }

    func rotateLeft() {
        let x = selectedShape.coordinates()[0]
        let y = selectedShape.coordinates()[1]
        remove(x, y)
        selectedShape.rotateLeft()
        merge(x, y)

        printAsTable()
    }

    func rotateRight() {
        let x = selectedShape.coordinates()[0]
        let y = selectedShape.coordinates()[1]
        remove(x, y)
        selectedShape.rotateRight()
        merge(x, y)

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
        merge(x, y)
        printAsTable()
    }

    private func drop() {

    }
}

public protocol Shape {

}

public final class ShapeA {
    
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

    func current() -> [[Int]] {
        return matrix[currentPosition]
    }

    func coordinates() -> [Int] {
        return [x, y]
    }

    func rotateLeft() {
        currentPosition += 1

        if currentPosition >= 4 {
            currentPosition = 0
        }
    }

    func rotateRight() {
        currentPosition -= 1

        if currentPosition < 0 {
            currentPosition = 3
        }
    }

    func setCoordinates(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    func leftCollision() -> Int {
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
}

//public enum Utils {
//    public static func randomShape() -> Shape {
//
//    }
//}
