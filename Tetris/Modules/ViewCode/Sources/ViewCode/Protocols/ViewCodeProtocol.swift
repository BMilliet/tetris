public protocol ViewCodeProtocol {
    func setSubviews()
    func setConstraints()
    func extraSetups()
    func setupView()
}

public extension ViewCodeProtocol {
    func extraSetups() {}
    func setupView() {
        setSubviews()
        setConstraints()
        extraSetups()
    }
}
