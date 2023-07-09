import UIKit

final class ControlPanelView: UIView {

    private lazy var controlPanel: UIView = {
        let panel = UIView()
        panel.backgroundColor = .lightGray
        return panel
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
        self.size(height: 60)
        controlPanel.setAnchorsEqual(to: self)

        controlPanel.addSubview(buttonLeft)
        controlPanel.addSubview(buttonDown)
        controlPanel.addSubview(buttonRight)
        controlPanel.addSubview(rotateLeftButton)
        controlPanel.addSubview(rotateRightButton)

        rotateLeftButton.centerYEqual(to: controlPanel)
        rotateRightButton.centerYEqual(to: controlPanel)

        rotateLeftButton.anchor(leading: controlPanel.leadingAnchor, paddingLeft: 22)
        rotateRightButton.anchor(trailing: controlPanel.trailingAnchor, paddingRight: 22)

        buttonDown.centerXYEqual(to: controlPanel)
        buttonLeft.centerYEqual(to: controlPanel)
        buttonRight.centerYEqual(to: controlPanel)

        buttonLeft.anchor(trailing: buttonDown.leadingAnchor, paddingRight: 10)
        buttonRight.anchor(leading: buttonDown.trailingAnchor, paddingLeft: 10)
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

    func setButtonsEnabled(_ enabled: Bool) {
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
}
