import UIKit

public final class ShapeA: UIView {
    
    private var selectedPosition = Int(arc4random_uniform(2))

    required init?(coder: NSCoder) { return nil }
    public init() {
        super.init(frame: .zero)
    }
}
