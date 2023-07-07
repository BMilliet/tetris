struct MatrixHandler {

    private let COLUMNS = BOARDMATRIX_POS.first!
    private let ROWS = BOARDMATRIX_POS.last!

    func merge(_ shape: ShapeProtocol, _ matrix: [[Int]]) -> [[Int]] {
        let shapeMatrix = shape.current()
        var newMatrix = matrix
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]

        for (rowIndex, row) in shapeMatrix.enumerated() {
            for (columnIndex, column) in row.enumerated() {
                if column != 0 {

                    let newX = columnIndex + x
                    let newY = rowIndex + y

                    if newX >= 0 && newY >= 0 && newX <= COLUMNS-1 && newY <= ROWS-1 {
                        newMatrix[newY][newX] = column
                    }
                }
            }
        }

        return newMatrix
    }

    func remove(_ shape: ShapeProtocol, _ matrix: [[Int]]) -> [[Int]] {
        let shapeMatrix = shape.current()
        var newMatrix = matrix
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]

        for (rowIndex, row) in shapeMatrix.enumerated() {
            for (columnIndex, column) in row.enumerated() {
                if column != 0 {

                    let newX = columnIndex + x
                    let newY = rowIndex + y

                    if newX >= 0 && newY >= 0 && newX <= COLUMNS-1 && newY <= ROWS-1 {
                        newMatrix[newY][newX] = 0
                    }
                }
            }
        }

        return newMatrix
    }

    func collide(_ shape: ShapeProtocol, _ matrix: [[Int]]) -> CollisionTypes {
        let shapeMatrix = shape.current()
        let x = shape.coordinates()[0]
        let y = shape.coordinates()[1]

        if debug {
            print(shape)
        }

        for (rowIndex, row) in shapeMatrix.enumerated() {
            for (columnIndex, column) in row.enumerated() {

                let newX = columnIndex + x
                let newY = rowIndex + y

                // collide with another shape
                if newY > 0 && newY <= BOARDMATRIX_POS.last! - 1 && newX > -1 && newX <= BOARDMATRIX_POS.first! - 1 {
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
}
