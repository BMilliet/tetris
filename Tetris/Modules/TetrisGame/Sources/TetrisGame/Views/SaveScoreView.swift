import UIKit

public final class SaveScoreView: UIView {

    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()

    private lazy var labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        return stack
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "score:"
        return label
    }()

    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "0"
        return label
    }()

    private lazy var field: UITextField = {
        let field = UITextField()
        field.placeholder = "name"
        return field
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveScore), for: .touchUpInside)
        return button
    }()

    required init?(coder: NSCoder) { return nil }
    public init() {
        super.init(frame: .zero)

        self.addSubview(mainStack)
        mainStack.setAnchorsEqual(to: self, .init(top: 20, left: 20, bottom: 20, right: 20))
        mainStack.addArrangedSubview(labelsStack)
        mainStack.addArrangedSubview(field)
        mainStack.addArrangedSubview(saveButton)
        labelsStack.addArrangedSubview(scoreLabel)
        labelsStack.addArrangedSubview(pointsLabel)

        saveButton.size(height: 50, width: 200)
        field.size(height: 50)
        labelsStack.size(height: 50)
        scoreLabel.size(width: 80)

        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 10
    }

    func setScore(_ score: Int) {
        pointsLabel.text = "\(score)"
    }

    @objc private func saveScore() {
        guard let name = field.text,
              let score = Int(pointsLabel.text ?? "") else {

            print("could not save score")
            NotificationCenter.default.post(name: .savedScore, object: nil)
            return
        }

        if field.text?.isEmpty ?? true || pointsLabel.text?.isEmpty ?? true {
            return
        }

        let user = User(name: name, score: score)
        ScoreHandler.save(user)

        NotificationCenter.default.post(name: .savedScore, object: nil)
        self.endEditing(true)
    }
}

extension Notification.Name {
    static let savedScore = Notification.Name("savedScore")
}
