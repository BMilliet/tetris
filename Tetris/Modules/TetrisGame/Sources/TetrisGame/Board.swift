import UIKit

public final class Board {

    private let matrixHandler = MatrixHandler()
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


    func moveLeft(_ value: Int) {
        let shape = selectedShape
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]

        let newX = x - value

        horizontalMove(shape, x: newX, y: y)
    }

    func moveRight(_ value: Int) {
        let shape = selectedShape
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]

        let newX = x + value

        horizontalMove(shape, x: newX, y: y)
    }

    func moveDown() {
        let shape = selectedShape
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]
        var matrixCopy = matrix

        let newY = y + 1

        let copy = shape.copy()
        copy.setCoordinates(x, newY)

        matrixCopy = matrixHandler.remove(shape, matrixCopy)

        switch matrixHandler.collide(copy, matrixCopy) {
        case .floor, .anotherShape:
            createNewShape()
            return
        default:
            break
        }


        matrix = matrixHandler.remove(shape, matrix)
        shape.setCoordinates(x, newY)
        matrix = matrixHandler.merge(shape, matrix)
    }

    func rotateLeft() {
        let shape = selectedShape
        let copy = shape.copy()
        var matrixCopy = matrix

        matrixCopy = matrixHandler.remove(shape, matrixCopy)
        copy.rotateLeft()

        if matrixHandler.collide(copy, matrixCopy) != .none {
            return
        }

        matrix = matrixHandler.remove(shape, matrix)
        shape.rotateLeft()
        matrix = matrixHandler.merge(shape, matrix)
    }

    func rotateRight() {
        let shape = selectedShape
        let copy = shape.copy()
        var matrixCopy = matrix

        matrixCopy = matrixHandler.remove(shape, matrixCopy)
        copy.rotateRight()

        if matrixHandler.collide(copy, matrixCopy) != .none {
            return
        }

        matrix = matrixHandler.remove(shape, matrix)
        shape.rotateRight()
        matrix = matrixHandler.merge(shape, matrix)
    }

    private func horizontalMove(_ shape: ShapeProtocol, x: Int, y: Int) {
        let copy = shape.copy()
        var matrixCopy = matrix
        copy.setCoordinates(x, y)

        matrixCopy = matrixHandler.remove(shape, matrixCopy)
        if matrixHandler.collide(copy, matrixCopy) != .none {
            return
        }

        matrix = matrixHandler.remove(shape, matrix)
        shape.setCoordinates(x, y)
        matrix = matrixHandler.merge(shape, matrix)
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
}
