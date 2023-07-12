import UIKit

public final class DifficultyMenuView: UIView {

    private lazy var difficultyMenu: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.layer.cornerRadius = 10
        stack.spacing = 8
        return stack
    }()

    private lazy var difficultyPicker: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .lightGray
        stack.layer.cornerRadius = 10
        return stack
    }()

    private lazy var acceptDifficultyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setTitle("OK", for: .normal)
        button.addTarget(self, action: #selector(acceptDifficulty), for: .touchUpInside)
        return button
    }()

    private lazy var increaseDifficultyButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(increaseDifficulty), for: .touchUpInside)
        return button
    }()

    private lazy var decreaseDifficultyButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setTitle("-", for: .normal)
        button.addTarget(self, action: #selector(decreaseDifficulty), for: .touchUpInside)
        return button
    }()

    private lazy var difficultyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        label.text = ""
        return label
    }()

    required init?(coder: NSCoder) { return nil }
    public init() {
        super.init(frame: .zero)
        self.addSubview(difficultyMenu)
        difficultyMenu.setAnchorsEqual(to: self)
        difficultyMenu.addArrangedSubview(difficultyPicker)
        difficultyMenu.addArrangedSubview(acceptDifficultyButton)

        difficultyPicker.addArrangedSubview(decreaseDifficultyButton)
        difficultyPicker.addArrangedSubview(difficultyLabel)
        difficultyPicker.addArrangedSubview(increaseDifficultyButton)

        decreaseDifficultyButton.size(height: 50, width: 50)
        increaseDifficultyButton.size(height: 50, width: 50)
        difficultyLabel.size(height: 50, width: 140)
        acceptDifficultyButton.size(height: 50)

        self.isHidden = true
    }

    @objc private func acceptDifficulty() {
        NotificationCenter.default.post(name: .acceptDifficulty, object: nil)
    }

    @objc private func increaseDifficulty() {
        increaseDifficultyButton.blinkAnimation()
        NotificationCenter.default.post(name: .increaseDifficulty, object: nil)
    }

    @objc private func decreaseDifficulty() {
        decreaseDifficultyButton.blinkAnimation()
        NotificationCenter.default.post(name: .decreaseDifficulty, object: nil)
    }

    func setDifficultyLabel(_ str: String) {
        difficultyLabel.text = str
    }
}

extension Notification.Name {
    static let acceptDifficulty   = Notification.Name("acceptDifficulty")
    static let increaseDifficulty = Notification.Name("increaseDifficulty")
    static let decreaseDifficulty = Notification.Name("decreaseDifficulty")
}
