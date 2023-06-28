import UIKit
import Foundation

enum ColisionHandler {
    public static func moveHorizontally(_ value: CGFloat, shape: UIView, boardWidth: CGFloat) -> CGFloat {
        var realValue = value
        
        // adjust proportion
        
        if value > 0 {
            realValue += shape.frame.width
        }
        
        var newXPosition = shape.frame.minX + realValue
        
        // colision
        
        if newXPosition > boardWidth {
            newXPosition = boardWidth - shape.frame.width + 50
        } else if newXPosition < 0 {
            newXPosition = 0 + shape.frame.width - 50
        }
        
        return newXPosition
    }
}
