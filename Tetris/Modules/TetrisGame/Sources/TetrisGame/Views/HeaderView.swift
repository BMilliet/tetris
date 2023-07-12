import UIKit

final class HeaderView: UIView {

    private lazy var nextShape: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "score:"
        return label
    }()

    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "0"
        return label
    }()

    required init?(coder: NSCoder) { return nil }
    public init() {
        super.init(frame: .zero)
        self.addSubview(nextShape)
        self.addSubview(scoreLabel)
        self.addSubview(pointsLabel)
        self.backgroundColor = .black

        self.size(height: 60)
        nextShape.size(height: 50, width: 50)
        scoreLabel.size(height: 30, width: 70)
        pointsLabel.size(height: 30, width: 200)

        nextShape.centerYEqual(to: self)
        scoreLabel.centerYEqual(to: self)
        pointsLabel.centerYEqual(to: self)

        nextShape.anchor(trailing: self.trailingAnchor, paddingRight: 42)
        scoreLabel.anchor(leading: self.leadingAnchor, paddingLeft: 42)
        pointsLabel.anchor(leading: scoreLabel.trailingAnchor)
    }

    func setNextShape(_ matrix: [[Int]]) {
        nextShape.subviews.forEach { $0.removeFromSuperview() }

        let size: CGFloat = 10

        for (ir, row) in matrix.enumerated() {
            for (ic, column) in row.enumerated() {
                if column != 0 {
                    let x = CGFloat(ic) * size + 8
                    let y = CGFloat(ir) * size + 8

                    let newCube = Cube(color: Colors.get(column))

                    nextShape.addSubview(newCube)
                    newCube.frame = CGRect(x: x, y: y, width: size, height: size)
                }
            }
        }
    }

    func setPointsLabel(_ points: Int) {
        let current = Int(pointsLabel.text!)!

        if points == 0 {
            pointsLabel.text = "\(points)"
        }

        if current >= points {
            return
        }

        addPointsAnimation(points - current)
        pointsLabel.text = "\(points)"
    }

    func addPointsAnimation(_ points: Int) {
        let newPoints = UILabel()
        newPoints.textColor = .green
        newPoints.textAlignment = .left
        newPoints.font = .boldSystemFont(ofSize: 20)
        newPoints.text = "+\(points)"
        newPoints.alpha = 0

        self.addSubview(newPoints)
        newPoints.setAnchorsEqual(to: pointsLabel, .init(top: 0, left: 0, bottom: 0, right: 48))
        newPoints.upDownFade()
    }
}
