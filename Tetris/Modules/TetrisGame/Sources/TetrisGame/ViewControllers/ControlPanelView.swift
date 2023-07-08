import UIKit

final class ControlPanelView: UIView {

    private lazy var controlPanel: UIView = {
        let panel = UIView()
        panel.backgroundColor = .lightGray
        panel.size(height: 100)
        return panel
    }()

    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        label.text = "0"
        return label
    }()

    private lazy var buttonDown: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.size(height: 50, width: 50)
        button.setImage(UIImage(systemName: "arrow.down")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapDown), for: .touchUpInside)
        return button
    }()

    private lazy var buttonRight: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.size(height: 50, width: 50)
        button.setImage(UIImage(systemName: "arrow.right")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapRight), for: .touchUpInside)
        return button
    }()

    private lazy var buttonLeft: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.size(height: 50, width: 50)
        button.setImage(UIImage(systemName: "arrow.left")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapLeft), for: .touchUpInside)
        return button
    }()

    private lazy var rotateLeftButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.size(height: 50, width: 50)
        button.setImage(UIImage(systemName: "arrow.uturn.right")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(rotateLeft), for: .touchUpInside)
        return button
    }()

    private lazy var rotateRightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.size(height: 50, width: 50)
        button.setImage(UIImage(systemName: "arrow.uturn.left")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(rotateRight), for: .touchUpInside)
        return button
    }()


    required init?(coder: NSCoder) { return nil }
    public init() {
        super.init(frame: .zero)

        self.addSubview(controlPanel)
        controlPanel.setAnchorsEqual(to: self)

        controlPanel.addSubview(buttonLeft)
        controlPanel.addSubview(buttonDown)
        controlPanel.addSubview(buttonRight)
        controlPanel.addSubview(rotateLeftButton)
        controlPanel.addSubview(rotateRightButton)
        controlPanel.addSubview(pointsLabel)

        pointsLabel.anchor(bottom: controlPanel.topAnchor, paddingBottom: 4)
        pointsLabel.centerXEqual(to: controlPanel)
        pointsLabel.size(height: 60, width: 100)

        rotateLeftButton.centerYEqual(to: controlPanel)
        rotateRightButton.centerYEqual(to: controlPanel)

        rotateLeftButton.anchor(leading: controlPanel.leadingAnchor, paddingLeft: 10)
        rotateRightButton.anchor(trailing: controlPanel.trailingAnchor, paddingRight: 10)

        buttonDown.centerXYEqual(to: controlPanel)
        buttonLeft.centerYEqual(to: controlPanel)
        buttonRight.centerYEqual(to: controlPanel)

        buttonLeft.anchor(trailing: buttonDown.leadingAnchor, paddingRight: 10)
        buttonRight.anchor(leading: buttonDown.trailingAnchor, paddingLeft: 10)

        NotificationCenter.default.addObserver(self, selector: #selector(setButtonsEnabled(_:)), name: .setButtonsEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setPointsLabel(_:)), name: .setPointsLabel, object: nil)
    }

    @objc private func tapDown() {
        NotificationCenter.default.post(name: .tapDown, object: nil)
    }

    @objc private func tapRight() {
        NotificationCenter.default.post(name: .tapRight, object: nil)
    }

    @objc private func tapLeft() {
        NotificationCenter.default.post(name: .tapLeft, object: nil)
    }

    @objc private func rotateLeft() {
        NotificationCenter.default.post(name: .rotateLeft, object: nil)
    }

    @objc private func rotateRight() {
        NotificationCenter.default.post(name: .rotateRight, object: nil)
    }

    @objc private func setPointsLabel(_ notification: Notification) {
        pointsLabel.text = notification.userInfo?["pointsLabel"] as? String ?? ""
    }

    @objc private func setButtonsEnabled(_ notification: Notification) {
        let enabled = notification.userInfo?["setButtonsEnabled"] as? Bool ?? false

        rotateLeftButton.isEnabled = enabled
        rotateRightButton.isEnabled = enabled
        buttonLeft.isEnabled = enabled
        buttonRight.isEnabled = enabled
        buttonDown.isEnabled = enabled
    }
}

extension Notification.Name {
    static let tapDown     = Notification.Name("tapDown")
    static let tapRight    = Notification.Name("tapRight")
    static let tapLeft     = Notification.Name("tapLeft")
    static let rotateLeft  = Notification.Name("rotateLeft")
    static let rotateRight = Notification.Name("rotateRight")
    static let setPointsLabel  = Notification.Name("setPointsLabel")
    static let setButtonsEnabled  = Notification.Name("setButtonsEnabled")
}
