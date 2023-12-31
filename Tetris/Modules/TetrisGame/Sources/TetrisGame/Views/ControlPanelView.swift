import UIKit

final class ControlPanelView: UIView {

    private lazy var controlPanel: UIView = {
        let panel = UIView()
        panel.backgroundColor = .lightGray
        return panel
    }()

    private lazy var arrowDown: TriangleDownView = {
        let view = TriangleDownView()
        view.backgroundColor = .clear
        view.size(height: 30, width: 40)
        return view
    }()

    private lazy var arrowRight: TriangleRightView = {
        let view = TriangleRightView()
        view.backgroundColor = .clear
        view.size(height: 40, width: 30)
        return view
    }()

    private lazy var arrowLeft: TriangleLeftView = {
        let view = TriangleLeftView()
        view.backgroundColor = .clear
        view.size(height: 40, width: 30)
        return view
    }()

    private lazy var buttonLayoutDown: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.darkGray.cgColor
        return view
    }()

    private lazy var buttonLayoutRight: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.darkGray.cgColor
        return view
    }()

    private lazy var buttonLayoutLeft: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.darkGray.cgColor
        return view
    }()

    private lazy var buttonDown: UIView = {
        let view = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDown))
        view.addGestureRecognizer(tap)
        return view
    }()

    private lazy var buttonRight: UIView = {
        let view = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapRight))
        view.addGestureRecognizer(tap)
        return view
    }()

    private lazy var buttonLeft: UIView = {
        let view = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLeft))
        view.addGestureRecognizer(tap)
        return view
    }()

    private lazy var rotateLeftButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.size(height: 50, width: 50)
        button.setTitle("L", for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(rotateLeft), for: .touchUpInside)
        return button
    }()

    private lazy var rotateRightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.size(height: 50, width: 50)
        button.setTitle("R", for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(rotateRight), for: .touchUpInside)
        return button
    }()


    required init?(coder: NSCoder) { return nil }
    public init() {
        super.init(frame: .zero)

        self.addSubview(controlPanel)
        self.size(height: 60)
        controlPanel.setAnchorsEqual(to: self)

        controlPanel.addSubview(arrowLeft)
        controlPanel.addSubview(arrowDown)
        controlPanel.addSubview(arrowRight)
        controlPanel.addSubview(buttonLayoutLeft)
        controlPanel.addSubview(buttonLayoutDown)
        controlPanel.addSubview(buttonLayoutRight)
        controlPanel.addSubview(buttonLeft)
        controlPanel.addSubview(buttonDown)
        controlPanel.addSubview(buttonRight)
        controlPanel.addSubview(rotateLeftButton)
        controlPanel.addSubview(rotateRightButton)

        rotateLeftButton.centerYEqual(to: controlPanel)
        rotateRightButton.centerYEqual(to: controlPanel)

        rotateLeftButton.anchor(leading: controlPanel.leadingAnchor, paddingLeft: 22)
        rotateRightButton.anchor(trailing: controlPanel.trailingAnchor, paddingRight: 22)

        arrowDown.centerXYEqual(to: controlPanel)
        arrowLeft.centerYEqual(to: controlPanel)
        arrowRight.centerYEqual(to: controlPanel)

        arrowLeft.anchor(trailing: arrowDown.leadingAnchor, paddingRight: 30)
        arrowRight.anchor(leading: arrowDown.trailingAnchor, paddingLeft: 30)

        buttonLayoutDown.setAnchorsEqual(to: arrowDown, .init(top: -11, left: -6, bottom: -11, right: -6))
        buttonLayoutLeft.setAnchorsEqual(to: arrowLeft, .init(top: -6, left: -8, bottom: -6, right: -12))
        buttonLayoutRight.setAnchorsEqual(to: arrowRight, .init(top: -6, left: -12, bottom: -6, right: -8))

        buttonDown.setAnchorsEqual(to: buttonLayoutDown)
        buttonLeft.setAnchorsEqual(to: buttonLayoutLeft)
        buttonRight.setAnchorsEqual(to: buttonLayoutRight)
    }

    @objc private func tapDown() {
        buttonDown.blink()
        arrowDown.blink()
        NotificationCenter.default.post(name: .tapDown, object: nil)
    }

    @objc private func tapRight() {
        buttonRight.blink()
        arrowRight.blink()
        NotificationCenter.default.post(name: .tapRight, object: nil)
    }

    @objc private func tapLeft() {
        buttonLeft.blink()
        arrowLeft.blink()
        NotificationCenter.default.post(name: .tapLeft, object: nil)
    }

    @objc private func rotateLeft() {
        rotateLeftButton.blink()
        NotificationCenter.default.post(name: .rotateLeft, object: nil)
    }

    @objc private func rotateRight() {
        rotateRightButton.blink()
        NotificationCenter.default.post(name: .rotateRight, object: nil)
    }

    func setButtonsEnabled(_ enabled: Bool) {
        buttonLeft.isUserInteractionEnabled = enabled
        buttonRight.isUserInteractionEnabled = enabled
        buttonDown.isUserInteractionEnabled = enabled
    }
}

extension Notification.Name {
    static let tapDown     = Notification.Name("tapDown")
    static let tapRight    = Notification.Name("tapRight")
    static let tapLeft     = Notification.Name("tapLeft")
    static let rotateLeft  = Notification.Name("rotateLeft")
    static let rotateRight = Notification.Name("rotateRight")
}
