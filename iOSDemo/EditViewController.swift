import UIKit
import SweetUIKit

class EditViewController: UIViewController, KeyboardAwareAccessoryViewDelegate {

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(withAutoLayout: true)

        return view
    }()

    lazy var textField: UITextField = {
        let view = UITextField(withAutoLayout: true)
        view.borderStyle = .roundedRect

        return view
    }()

    lazy var textInputView: UIView = {
        let view = UIView(withAutoLayout: true)
        view.backgroundColor = .magenta

        return view
    }()

    // TODO: Find a way to make this work implicitly.
    override var inputAccessoryView: UIView? {
        return self.keyboardAwareInputView
    }

    var textInputBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.scrollView.backgroundColor = .white
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.isScrollEnabled = true
        self.scrollView.keyboardDismissMode = .interactive

        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.textInputView)
        self.scrollView.addSubview(self.textField)

        self.scrollView.fillSuperview()

        self.textField.set(height: 38)
        self.textField.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 80).isActive = true
        self.textField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        self.textField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.9).isActive = true

        self.textInputView.set(height: 48)
        self.textInputView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.textInputView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.textInputBottomConstraint = self.textInputView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        self.textInputBottomConstraint.isActive = true
    }

    func inputView(_ inputView: KeyboardAwareInputAccessoryView, shouldUpdatePosition keyboardOriginYDistance: CGFloat) {
        self.textInputBottomConstraint.constant = keyboardOriginYDistance
        self.view.layoutIfNeeded()
    }
}
