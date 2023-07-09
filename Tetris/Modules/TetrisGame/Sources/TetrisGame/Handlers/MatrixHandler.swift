enum MatrixHandler {

    static func merge(_ shape: ShapeProtocol, _ matrix: [[Int]]) -> [[Int]] {
        let shapeMatrix = shape.current()
        var newMatrix = matrix
        let x = shape.xPoint()
        let y = shape.yPoint()

        for (rowIndex, row) in shapeMatrix.enumerated() {
            for (columnIndex, column) in row.enumerated() {
                if column != 0 {

                    let newX = columnIndex + x
                    let newY = rowIndex + y

                    if newX >= 0 && newY >= 0 && newX <= BOARD_MATRIX_WIDTH - 1 && newY <= BOARD_MATRIX_HEIGHT - 1 {
                        newMatrix[newY][newX] = column
                    }
                }
            }
        }

        return newMatrix
    }

    static func remove(_ shape: ShapeProtocol, _ matrix: [[Int]]) -> [[Int]] {
        let shapeMatrix = shape.current()
        var newMatrix = matrix
        let x = shape.xPoint()
        let y = shape.yPoint()

        for (rowIndex, row) in shapeMatrix.enumerated() {
            for (columnIndex, column) in row.enumerated() {
                if column != 0 {

                    let newX = columnIndex + x
                    let newY = rowIndex + y

                    if newX >= 0 && newY >= 0 && newX <= BOARD_MATRIX_WIDTH - 1 && newY <= BOARD_MATRIX_HEIGHT - 1 {
                        newMatrix[newY][newX] = 0
                    }
                }
            }
        }

        return newMatrix
    }

    static func collide(_ shape: ShapeProtocol, _ matrix: [[Int]]) -> CollisionTypes {
        let shapeMatrix = shape.current()
        let x = shape.xPoint()
        let y = shape.yPoint()

        if DEBUG {
            print(shape)
        }

        for (rowIndex, row) in shapeMatrix.enumerated() {
            for (columnIndex, column) in row.enumerated() {

                let newX = columnIndex + x
                let newY = rowIndex + y

                // collide with another shape
                if newY > 0 && newY <= BOARD_MATRIX_HEIGHT - 1 && newX > -1 && newX <= BOARD_MATRIX_WIDTH - 1 {
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
                if newX >= BOARD_MATRIX_WIDTH && column != 0 {
                    return .rightWall
                }

                // collide floor
                if newY >= BOARD_MATRIX_HEIGHT && column != 0 {
                    return .floor
                }
            }
        }

        return .none
    }
}
