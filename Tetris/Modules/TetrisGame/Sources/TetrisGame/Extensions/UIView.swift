import UIKit

extension UIView {

    func confetti() {
        self.confetti(x: CGFloat(arc4random_uniform(UInt32(self.frame.maxX))),
                      y: CGFloat(arc4random_uniform(UInt32(self.frame.maxY))))
        self.confetti(x: CGFloat(arc4random_uniform(UInt32(self.frame.maxX))),
                      y: CGFloat(arc4random_uniform(UInt32(self.frame.maxY))))

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.confetti(x: CGFloat(arc4random_uniform(UInt32(self.frame.maxX))),
                          y: CGFloat(arc4random_uniform(UInt32(self.frame.maxY))))
            self.confetti(x: CGFloat(arc4random_uniform(UInt32(self.frame.maxX))),
                          y: CGFloat(arc4random_uniform(UInt32(self.frame.maxY))))
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.confetti(x: CGFloat(arc4random_uniform(UInt32(self.frame.maxX))),
                          y: CGFloat(arc4random_uniform(UInt32(self.frame.maxY))))
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.confetti(x: CGFloat(arc4random_uniform(UInt32(self.frame.maxX))),
                          y: CGFloat(arc4random_uniform(UInt32(self.frame.maxY))))
            self.confetti(x: CGFloat(arc4random_uniform(UInt32(self.frame.maxX))),
                          y: CGFloat(arc4random_uniform(UInt32(self.frame.maxY))))
            self.confetti(x: CGFloat(arc4random_uniform(UInt32(self.frame.maxX))),
                          y: CGFloat(arc4random_uniform(UInt32(self.frame.maxY))))
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            self.confetti(x: CGFloat(arc4random_uniform(UInt32(self.frame.maxX))),
                          y: CGFloat(arc4random_uniform(UInt32(self.frame.maxY))))
            self.confetti(x: CGFloat(arc4random_uniform(UInt32(self.frame.maxX))),
                          y: CGFloat(arc4random_uniform(UInt32(self.frame.maxY))))
        }
    }

    private func confetti(x: CGFloat, y: CGFloat) {
        for _ in 0..<20 {
            let cube = UIView()
            cube.backgroundColor = Colors.get()
            cube.alpha = 0

            self.addSubview(cube)

            cube.frame = CGRect(x: x, y: y, width: 10, height: 10)
            cube.confettiAnimation()
        }
    }

    private func confettiAnimation() {

        var directionX = 1
        var directionY = 1

        if Int(arc4random_uniform(2)) == 1 {
            directionX = -1
        }

        if Int(arc4random_uniform(2)) == 1 {
            directionY = -1
        }

        let x = CGFloat(Int(arc4random_uniform(100)) * directionX)
        let y = CGFloat(Int(arc4random_uniform(100)) * directionY)

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.toValue = CGFloat.pi * 2.0
        rotationAnimation.duration = 0.5
        rotationAnimation.repeatCount = .infinity
        self.layer.add(rotationAnimation, forKey: "rotationAnimation")

        UIView.animate(withDuration: 1.2, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(translationX: -x, y: -y).scaledBy(x: 0.8, y: 0.8)
        }) { _ in
            UIView.animate(withDuration: 1, delay: 0.2, animations: {
                self.alpha = 0
                self.transform = .identity
                self.center.x -= x
                self.center.y += (200 - y)
            }) { _ in
                self.removeFromSuperview()
            }
        }
    }
}
