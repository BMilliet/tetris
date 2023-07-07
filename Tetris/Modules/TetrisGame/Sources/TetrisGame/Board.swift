import UIKit

public final class Board {

    private lazy var selectedShape: ShapeProtocol = ShapeA()
    private let COLUMNS = BOARDMATRIX_POS.first!
    private let ROWS = BOARDMATRIX_POS.last!
    private let matrixHandler = MatrixHandler()

    private var matrix = [[Int]]()
    private var points = 0

    var gameOver = false

    init() {
        drawMatrix()
        createNewShape()
    }

    func getMatrix() -> [[Int]] {
        return matrix
    }

    func getPoints() -> Int {
        return points
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
        matrixCopy = matrixHandler.remove(copy, matrixCopy)
        copy.setCoordinates(x, newY)

        let collision = matrixHandler.collide(copy, matrixCopy)

        if debug {
            print(collision)
            print("=== vertical ===")
        }

        switch collision {
        case .floor, .anotherShape:
            checkGameStatus()
            createNewShape()
            return
        case .invalid:
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

    func removeRowIfPossible() {
        var newMatrix = [[Int]]()
        var removedRows = 0

        matrix.forEach { row in
            if row.allSatisfy({ $0 != 0 }) {
                removedRows += 1
            } else {
                newMatrix.append(row)
            }

        }

        for _ in 0..<removedRows {
            newMatrix.insert(Array(repeating: 0, count: COLUMNS), at: 0)
        }

        points += 100 * removedRows
        matrix = newMatrix
    }

    private func createNewShape() {
        removeRowIfPossible()
        selectedShape = ShapeUtils.random()
    }

    private func checkGameStatus() {
        gameOver = selectedShape.coordinates()[1] < 0
    }

    private func horizontalMove(_ shape: ShapeProtocol, x: Int, y: Int) {
        let copy = shape.copy()
        var matrixCopy = matrix
        
        matrixCopy = matrixHandler.remove(copy, matrixCopy)
        copy.setCoordinates(x, y)

        let collision = matrixHandler.collide(copy, matrixCopy)

        if debug {
            print(collision)
            print("=== horizontal ===")
        }

        if collision != .none {
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
}
