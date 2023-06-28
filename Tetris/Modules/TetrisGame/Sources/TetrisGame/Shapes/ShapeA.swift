import UIKit

public final class ShapeA: UIView, TetrisShape {
    
    private var selectedPosition = Int(arc4random_uniform(2))
    private var positionsMap = [Int: UIView]()
    
    private lazy var vertical: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.isHidden = true
        return view
    }()
    
    private lazy var horizontal: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.isHidden = true
        return view
    }()
    
    required init?(coder: NSCoder) { return nil }
    public init(unit: CGFloat) {
        super.init(frame: .zero)
        
        self.addSubviews([vertical, horizontal])
        setConstraints()
        setSizes(unit)
        start()
    }
    
    public func selected() -> UIView {
        guard let selected = positionsMap[selectedPosition] else {
            fatalError("invalid position")
        }
        
        return selected
    }
    
    public func rotateLeft(_ board: Board) {
        if selectedPosition == 0 {
            selectedPosition = 1
        } else {
            selectedPosition = 0
        }
        
        render()
    }
    
    public func rotateRigth(_ board: Board) {
        if selectedPosition == 1 {
            selectedPosition = 0
        } else {
            selectedPosition = 1
        }
        
        render()
    }
    
    public func moveLeft(_ boardWidth: CGFloat) -> CGFloat {
        return moveHorizontal(-25, boardWidth)
    }
    
    public func moveRight(_ boardWidth: CGFloat) -> CGFloat {
        return moveHorizontal(25, boardWidth)
    }
    
    private func moveHorizontal(_ value: CGFloat, _ boardWidth: CGFloat) -> CGFloat {
        let selected = selected()
        
        var realValue = value
        
        if value > 0 {
            realValue += selected.frame.width
        }
        
        var newXPosition = self.frame.minX + realValue
        
        // colision
        
        var padding: CGFloat = 50
        
//        if selectedPosition == 0 {
//            padding = 50
//        } else {
//            padding
//        }
        
        if newXPosition > boardWidth {
            newXPosition = boardWidth - selected.frame.width + padding
        } else if newXPosition < 0 {
            newXPosition = selected.frame.width - padding
        }
        
        return newXPosition
    }
    
    
    private func start() {
        positionsMap[0] = horizontal
        positionsMap[1] = vertical
        render()
    }
    
    private func render() {
        hideAll()
        selected().isHidden = false
    }
    
    private func hideAll() {
        vertical.isHidden = true
        horizontal.isHidden = true
    }
    
    private func setConstraints() {
        vertical.centerXYEqual(to: self)
        horizontal.centerXYEqual(to: self)
    }
    
    private func setSizes(_ unit: CGFloat) {
        let max = unit * 4
        
        self.size(height: max, width: max)
        
        vertical.size(height: max, width: unit)
        horizontal.size(height: unit, width: max)
    }
}
