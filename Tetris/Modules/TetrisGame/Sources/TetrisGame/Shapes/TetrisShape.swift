import UIKit

public protocol TetrisShape: UIView {
    func absWidth() -> CGFloat
    func absHeight() -> CGFloat
    func CollisionWidth() -> CGFloat
    func CollisionHeight() -> CGFloat
//    func rotateLeft(_ board: Board)
//    func rotateRigth(_ board: Board)
//    func moveLeft(_ boardWidth: CGFloat) -> CGFloat
//    func moveRight(_ boardWidth: CGFloat) -> CGFloat
}
