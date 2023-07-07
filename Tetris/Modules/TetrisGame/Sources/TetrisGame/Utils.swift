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
