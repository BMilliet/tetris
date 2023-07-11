import UIKit

public let SHAPE_DEFAULT_X: Int = 5
public let SHAPE_DEFAULT_Y: Int = -2

public let BOARD_MATRIX_WIDTH: Int  = 13
public let BOARD_MATRIX_HEIGHT: Int =  Int(UIScreen.main.bounds.size.height / 32)

public let CUBE_SIZE: CGFloat = UIScreen.main.bounds.size.width / 16.5
public let BOARDVIEW_WIDTH: CGFloat = CGFloat(BOARD_MATRIX_WIDTH) * CUBE_SIZE
public let BOARDVIEW_HEIGHT: CGFloat = CGFloat(BOARD_MATRIX_HEIGHT) * CUBE_SIZE

public let SCORE_BASE = 50
public let SCORE_BONUS = 5

public enum CollisionTypes {
    case leftWall, rightWall, floor, anotherShape, none
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

public enum MatrixUtils {
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

public enum MatrixFactory {
    static func create(_ shape: Int? = nil) -> [[[Int]]] {
        let color = Int(arc4random_uniform(8)) + 1
        let shape = shape ?? Int(arc4random_uniform(6))

        switch shape {
        case 0:
            return [
            [
                [0,0,0],
                [color,color,color],
                [0,color,0]
            ],

            [
                [0,color,0],
                [color,color,0],
                [0,color,0]
            ],

            [
                [0,color,0],
                [color,color,color],
                [0,0,0]
            ],

            [
                [0,color,0],
                [0,color,color],
                [0,color,0]
            ]
        ]
        case 1:
            return [
            [
                [0,color,0,0],
                [0,color,0,0],
                [0,color,0,0],
                [0,color,0,0]
            ],

            [
                [0,0,0,0],
                [color,color,color,color],
                [0,0,0,0],
                [0,0,0,0],
            ]
        ]
        case 2:
            return [
            [
                [color,color],
                [color,color]
            ]
        ]
        case 3:
            return [
            [
                [0,color,0],
                [0,color,0],
                [0,color,color]
            ],

            [
                [0,0,color],
                [color,color,color],
                [0,0,0]
            ],

            [
                [color,color,0],
                [0,color,0],
                [0,color,0]
            ],

            [
                [0,0,0],
                [color,color,color],
                [color,0,0]
            ]
        ]
        case 4:
            return [
            [
                [0,color,0],
                [0,color,0],
                [color,color,0]
            ],

            [
                [color,0,0],
                [color,color,color],
                [0,0,0]
            ],

            [
                [0,color,color],
                [0,color,0],
                [0,color,0]
            ],

            [
                [0,0,0],
                [color,color,color],
                [0,0,color]
            ]
        ]
        case 5:
            return [
            [
                [0,color,color],
                [color,color,0],
                [0,0,0]
            ],

            [
                [color,0,0],
                [color,color,0],
                [0,color,0]
            ]
        ]
        case 6:
            return [
            [
                [color,color,0],
                [0,color,color],
                [0,0,0]
            ],

            [
                [0,color,0],
                [color,color,0],
                [color,0,0]
            ]
        ]
        default:
            return [
            [
                [color,color],
                [color,color]
            ]
        ]
        }
    }
}
