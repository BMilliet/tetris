public protocol ShapeProtocol {
    func current() -> [[Int]]
    func coordinates() -> [Int]
    func setCoordinates(_ x: Int, _ y: Int)
    func rotateLeft()
    func rotateRight()
    func rightCollision() -> Int
    func leftCollision() -> Int
    func copy() -> ShapeProtocol
    func setPosition(_ int: Int)
}
