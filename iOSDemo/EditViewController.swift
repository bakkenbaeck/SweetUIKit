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
        return keyboardAwareInputView
    }

    var textInputBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        scrollView.backgroundColor = .white
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.keyboardDismissMode = .interactive

        view.addSubview(scrollView)
        view.addSubview(textInputView)
        scrollView.addSubview(textField)

        scrollView.fillSuperview()

        textField.set(height: 38)
        textField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80).isActive = true
        textField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9).isActive = true

        textInputView.set(height: 48)
        textInputView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        textInputView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        if #available(iOS 11.0, *) {
            self.textInputBottomConstraint = self.textInputView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        } else {
            textInputBottomConstraint = textInputView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        }
        textInputBottomConstraint.isActive = true
    }

    func inputView(_ inputView: KeyboardAwareInputAccessoryView, shouldUpdatePosition keyboardOriginYDistance: CGFloat) {
        textInputBottomConstraint.constant = keyboardOriginYDistance
        view.layoutIfNeeded()
    }
}
