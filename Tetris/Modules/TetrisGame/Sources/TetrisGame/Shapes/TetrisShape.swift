import UIKit

public protocol TetrisShape: UIView {
    func absWidth() -> CGFloat
    func absHeight() -> CGFloat
    func collisionWidth() -> CGFloat
    func collisionHeight() -> CGFloat
    func getMatrix() -> [[Int]]
//    func rotateLeft(_ board: Board)
//    func rotateRigth(_ board: Board)
//    func moveLeft(_ boardWidth: CGFloat) -> CGFloat
//    func moveRight(_ boardWidth: CGFloat) -> CGFloat
}
