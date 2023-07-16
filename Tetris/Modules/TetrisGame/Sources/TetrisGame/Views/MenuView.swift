import UIKit

final class MenuView: UIView {

    private lazy var menu: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.layer.cornerRadius = 10
        stack.spacing = 10
        return stack
    }()

    private lazy var newGameButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(startNewGame), for: .touchUpInside)
        return button
    }()

    private lazy var statsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.setTitle("Stats", for: .normal)
        button.addTarget(self, action: #selector(showStats), for: .touchUpInside)
        return button
    }()

    required init?(coder: NSCoder) { return nil }
    public init() {
        super.init(frame: .zero)
        self.addSubview(menu)
        menu.addArrangedSubview(newGameButton)
        menu.addArrangedSubview(statsButton)

        menu.setAnchorsEqual(to: self)
        newGameButton.size(height: 50, width: UIScreen.main.bounds.size.width - 100)
        statsButton.size(height: 50, width: UIScreen.main.bounds.size.width - 100)
    }

    @objc private func startNewGame() {
        NotificationCenter.default.post(name: .startNewGame, object: nil)
    }

    @objc private func showStats() {
        NotificationCenter.default.post(name: .showStats, object: nil)
    }
}

extension Notification.Name {
    static let showStats = Notification.Name("showStats")
    static let startNewGame = Notification.Name("startNewGame")
}
