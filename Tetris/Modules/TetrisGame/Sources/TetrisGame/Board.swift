import UIKit

public final class Board {
    
    private var matrix = [[Int]]()
    private var selectedShape = ShapeA()
    private var selectedShapeLastPlace = [4,4]

    init() {
        drawMatrix()
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

        selectedShapeLastPlace = [x, y]
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
        let x = selectedShapeLastPlace[0]
        let y = selectedShapeLastPlace[1]

        remove(x, y)
        merge(x - 1, y)

        printAsTable()
    }

    func moveRight() {
        let x = selectedShapeLastPlace[0]
        let y = selectedShapeLastPlace[1]

        remove(x, y)
        merge(x + 1, y)

        printAsTable()
    }

    func moveDown() {
        let x = selectedShapeLastPlace[0]
        let y = selectedShapeLastPlace[1]

        remove(x, y)
        merge(x, y + 1)

        printAsTable()
    }

    private func drawMatrix() {
        let rows    = 25
        let columns = 13

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
    
    //private var currentPosition = Int(arc4random_uniform(4))

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
        return matrix[1]
    }
}

//public enum Utils {
//    public static func randomShape() -> Shape {
//
//    }
//}
