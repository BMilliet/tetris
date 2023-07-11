import UIKit

class TriangleDownView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        context.beginPath()
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: rect.width, y: 0))
        context.addLine(to: CGPoint(x: rect.width / 2, y: rect.height))
        context.closePath()

        context.setFillColor(UIColor.darkGray.cgColor)
        context.fillPath()
    }
}

class TriangleLeftView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        context.beginPath()
        context.move(to: CGPoint(x: rect.width, y: 0))
        context.addLine(to: CGPoint(x: rect.width, y: rect.height))
        context.addLine(to: CGPoint(x: 0, y: rect.height / 2))
        context.closePath()

        context.setFillColor(UIColor.darkGray.cgColor)
        context.fillPath()
    }
}

class TriangleRightView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        context.beginPath()
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
        context.addLine(to: CGPoint(x: 0, y: rect.height))
        context.closePath()

        context.setFillColor(UIColor.darkGray.cgColor)
        context.fillPath()
    }
}
