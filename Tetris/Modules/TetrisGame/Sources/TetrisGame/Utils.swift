import UIKit

public let CUBE_SIZE: CGFloat       = 25
public let SHAPE_POS: [Int]         = [5, -2]
public let BOARDVIEW_POS: [CGFloat] = [326, 649]
public let BOARDMATRIX_POS: [Int]   = [13, 26]

public enum CollisionTypes {
    case leftWall, rightWall, floor, anotherShape, none
}
