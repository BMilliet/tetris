import UIKit

public final class Board {
    
    private var matrix = [[Int]]()
    private var selectedShape: ShapeProtocol = ShapeA()
    private var shouldCreateNewShape = false

    private let COLUMNS = 13
    private let ROWS = 26

    init() {
        drawMatrix()
    }

    private func createNewShape() {
        selectedShape = ShapeA()
        shouldCreateNewShape = false
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
                    shouldCreateNewShape = true
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

        let newX = x - 1

        let copy = shape.copy()
        copy.setCoordinates(newX, y)

        if collide(copy) != .none {
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

        let copy = shape.copy()
        copy.setCoordinates(newX, y)

        if collide(copy) != .none {
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

        let copy = shape.copy()
        copy.setCoordinates(x, newY)

        switch collide(copy) {
        case .floor, .anotherShape:
            if shouldCreateNewShape {
                createNewShape()
            }
            return
        default:
            break
        }

        remove(shape)

        shape.setCoordinates(x, newY)
        merge(shape)


        printAsTable()
    }

    func rotateLeft() {
        let shape = selectedShape
        let copy = shape.copy()

        copy.rotateLeft()

        switch collide(copy) {
        case .floor, .anotherShape:
            return
        case .leftWall:
            moveRight()
        case .rightWall:
            moveLeft()
        default:
            break
        }

        remove(shape)
        shape.rotateLeft()
        merge(shape)

        printAsTable()
    }

    func rotateRight() {
        let shape = selectedShape
        let copy = shape.copy()

        copy.rotateRight()

        switch collide(copy) {
        case .floor, .anotherShape:
            return
        case .leftWall:
            moveRight()
        case .rightWall:
            moveLeft()
        default:
            break
        }

        remove(shape)
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
