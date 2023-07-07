enum Rotation {
    case left, right
}

enum RotationHandler {
    static func rotate(sides: Int, current: Int, orientation: Rotation) -> Int {
        var resp = 0

        if sides == 4 {
            if orientation == .left {
                resp = rotateLeftFourSides(current)
            } else {
                resp = rotateRightFourSides(current)
            }
        } else if sides == 2 {
            resp = rotateTwoSides(current)
        }

        return resp
    }

    private static func rotateTwoSides(_ v: Int) -> Int {
        var currentPosition = v

        if currentPosition == 0 {
            currentPosition = 1
        } else {
            currentPosition = 0
        }

        return currentPosition
    }

    private static func rotateRightFourSides(_ v: Int) -> Int {
        var currentPosition = v
        currentPosition -= 1

        if currentPosition < 0 {
            currentPosition = 3
        }

        return currentPosition
    }

    private static func rotateLeftFourSides(_ v: Int) -> Int {
        var currentPosition = v
        currentPosition += 1

        if currentPosition >= 4 {
            currentPosition = 0
        }

        return currentPosition
    }
}
