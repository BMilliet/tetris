import UIKit

public protocol TetrisShape: UIView {
    func selected() -> UIView
    func rotateLeft(_ board: Board)
    func rotateRigth(_ board: Board)
    func moveLeft(_ boardWidth: CGFloat) -> CGFloat
    func moveRight(_ boardWidth: CGFloat) -> CGFloat
}
