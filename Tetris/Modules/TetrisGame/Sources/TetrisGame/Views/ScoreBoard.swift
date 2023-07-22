import UIKit

public final class ScoreBoard: UIView {

    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Scores"
        return label
    }()

    private lazy var scoreStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    required init?(coder: NSCoder) { return nil }
    public init() {
        super.init(frame: .zero)
        self.addSubview(mainStack)
        self.size(width: 250)
        mainStack.setAnchorsEqual(to: self, .init(top: 0, left: 8, bottom: 0, right: 8))
        mainStack.addArrangedSubview(title)
        mainStack.addArrangedSubview(scoreStack)

        let spacer = UIView()
        spacer.size(height: 8)

        mainStack.addArrangedSubview(spacer)

        self.backgroundColor = .darkGray
        self.layer.cornerRadius = 10

        title.size(height: 50)
    }

    func setScore(_ users: [User]) {
        scoreStack.subviews.forEach {
            $0.removeFromSuperview()
        }

        if users.isEmpty {
            let container = UIStackView()
            container.axis = .horizontal
            container.size(height: 50)
            container.backgroundColor = .lightGray

            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .darkGray
            label.font = .boldSystemFont(ofSize: 20)
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
            label.text = "Best 5 scores will appear here"

            container.addArrangedSubview(label)
            scoreStack.addArrangedSubview(container)
            return
        }

        let sorted = users.sorted(by: { $0.score > $1.score })

        sorted.forEach { user in
            let container = UIStackView()
            container.axis = .horizontal
            container.size(height: 50)
            container.backgroundColor = .lightGray

            let name = UILabel()
            name.size(width: 100)
            name.textAlignment = .left
            name.textColor = .darkGray
            name.font = .boldSystemFont(ofSize: 20)
            name.adjustsFontSizeToFitWidth = true
            name.minimumScaleFactor = 0.5

            let score = UILabel()
            score.textAlignment = .right
            score.textColor = .darkGray
            score.font = .boldSystemFont(ofSize: 20)
            score.adjustsFontSizeToFitWidth = true
            score.minimumScaleFactor = 0.5

            container.addArrangedSubview(name)
            container.addArrangedSubview(score)

            name.text = "   \(user.name):"
            score.text = "\(user.score)"

            scoreStack.addArrangedSubview(container)
        }
    }
}
