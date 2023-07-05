import UIKit

public let CUBE_SIZE: CGFloat       = 25
public let SHAPE_POS: [Int]         = [5, -2]
public let BOARDVIEW_POS: [CGFloat] = [326, 649]
public let BOARDMATRIX_POS: [Int]   = [13, 26]

// switch to debug mode
public let debug: Bool = true

public enum CollisionTypes {
    case leftWall, rightWall, floor, anotherShape, none, invalid
}

public enum Colors {
    static func get(_ n: Int) -> UIColor {
        switch n {
        case 0:
            return UIColor.green
        case 1:
            return UIColor.red
        case 2:
            return UIColor.blue
        case 3:
            return UIColor.cyan
        case 4:
            return UIColor.purple
        case 5:
            return UIColor.systemPink
        case 6:
            return UIColor.yellow
        case 7:
            return UIColor.orange
        case 8:
            return UIColor.magenta
        default:
            return UIColor.magenta
        }
    }
}

public enum ShapeUtils {
    static func random() -> ShapeProtocol {
        let n = Int(arc4random_uniform(6))

        switch n {
        case 0:
            return ShapeA()
        case 1:
            return ShapeB()
        case 2:
            return ShapeC()
        case 3:
            return ShapeD()
        case 4:
            return ShapeE()
        case 5:
            return ShapeF()
        case 6:
            return ShapeG()
        default:
            return ShapeA()
        }
    }

    static func printAsTable(_ m: [[Int]]) {
        var line = ""
        print("===========================")

        m.forEach { row in
            row.forEach {
                line += "\($0) "
            }
            print(line)
            line = ""
        }
    }
}
