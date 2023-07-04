import UIKit

public final class Board {
    
    private var matrix = [[Int]]()
    private var selectedShape: ShapeProtocol = ShapeA()

    private let COLUMNS = BOARDMATRIX_POS.first!
    private let ROWS = BOARDMATRIX_POS.last!

    init() {
        drawMatrix()
    }

    private func createNewShape() {
        selectedShape = ShapeA()
    }

    func getMatrix() -> [[Int]] {
        return matrix
    }

    private func merge(_ shape: ShapeProtocol) {
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

    func remove(_ shape: ShapeProtocol) {
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

    func collide(_ shape: ShapeProtocol) -> CollisionTypes {
        let shapeMatrix = shape.current()
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]

        print(shape)

        for (ir, row) in shapeMatrix.enumerated() {
            for (ic, column) in row.enumerated() {

                let newX = ic + x
                let newY = ir + y

                // collide with another shape
                if newY > 0 && newY <= BOARDMATRIX_POS.last! - 1 && newX > 0 && newX <= BOARDMATRIX_POS.first! - 1 {
                    let currentPoint = matrix[newY][newX]

                    if currentPoint != 0 && column != 0 {
                        return .anotherShape
                    }
                }

                // collide left wall
                if newX < 0 && column != 0 {
                    return .leftWall
                }

                // collide right wall
                if newX >= COLUMNS && column != 0 {
                    return .rightWall
                }

                // collide floor
                if newY >= ROWS && column != 0 {
                    return .floor
                }
            }
        }

        return .none
    }

    func moveLeft() {
        let shape = selectedShape
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]
        remove(shape)

        let newX = x - 1

        let copy = shape.copy()
        copy.setCoordinates(newX, y)


        if collide(copy) != .none {
            shape.setCoordinates(x, y)
        } else {
            shape.setCoordinates(newX, y)
        }

        merge(shape)
        printAsTable()
    }

    func moveRight() {
        let shape = selectedShape
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]
        remove(shape)

        let newX = x + 1

        let copy = shape.copy()
        copy.setCoordinates(newX, y)

        if collide(copy) != .none {
            shape.setCoordinates(x, y)
        } else {
            shape.setCoordinates(newX, y)
        }

        merge(shape)
    }

    func moveDown() {
        let shape = selectedShape
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]
        remove(shape)

        let newY = y + 1

        let copy = shape.copy()
        copy.setCoordinates(x, newY)

        switch collide(copy) {
        case .floor, .anotherShape:
            shape.setCoordinates(x, y)
            merge(shape)
            createNewShape()
            return
        default:
            break
        }


        shape.setCoordinates(x, newY)
        merge(shape)


        printAsTable()
    }

    func rotateLeft() {
        let shape = selectedShape
        let copy = shape.copy()
        remove(shape)

        copy.rotateLeft()

        switch collide(copy) {
        case .floor, .anotherShape:
            merge(shape)
            return
        case .leftWall:
            moveRight()
        case .rightWall:
            moveLeft()
        default:
            break
        }

        shape.rotateLeft()
        merge(shape)

        printAsTable()
    }

    func rotateRight() {
        let shape = selectedShape
        let copy = shape.copy()
        remove(shape)

        copy.rotateRight()

        switch collide(copy) {
        case .floor, .anotherShape:
            merge(shape)
            return
        case .leftWall:
            moveRight()
        case .rightWall:
            moveLeft()
        default:
            break
        }

        shape.rotateRight()
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
