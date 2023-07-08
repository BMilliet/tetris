public protocol ShapeProtocol {
    func current() -> [[Int]]
    func xPoint() -> Int
    func yPoint() -> Int
    func setCoordinates(_ x: Int, _ y: Int)
    func rotateLeft()
    func rotateRight()
    func copy() -> ShapeProtocol
    func setPosition(_ int: Int)
}
