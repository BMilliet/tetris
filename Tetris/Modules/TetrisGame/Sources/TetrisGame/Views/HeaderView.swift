import UIKit

final class HeaderView: UIView {

    private lazy var nextShape: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
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
        pointsLabel.size(height: 30, width: 100)

        nextShape.centerYEqual(to: self)
        scoreLabel.centerYEqual(to: self)
        pointsLabel.centerYEqual(to: self)

        nextShape.anchor(trailing: self.trailingAnchor, paddingRight: 42)
        scoreLabel.anchor(leading: self.leadingAnchor, paddingLeft: 42)
        pointsLabel.anchor(leading: scoreLabel.trailingAnchor)

        NotificationCenter.default.addObserver(self, selector: #selector(setPointsLabel(_:)), name: .setPointsLabel, object: nil)
    }

    @objc private func setPointsLabel(_ notification: Notification) {
        pointsLabel.text = notification.userInfo?["pointsLabel"] as? String ?? ""
    }
}

extension Notification.Name {
    static let setPointsLabel = Notification.Name("setPointsLabel")
}
