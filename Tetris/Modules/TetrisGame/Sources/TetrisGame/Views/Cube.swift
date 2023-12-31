import UIKit

public final class Cube: UIView {
    required init?(coder: NSCoder) { return nil }
    public init(color: UIColor = .red) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
