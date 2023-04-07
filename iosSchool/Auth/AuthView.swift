//
//  AuthView.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import UIKit

protocol AuthView: UIView {
    var registrationAction: (() -> Void)? {get set}

    func update(with data: AuthViewData)
}

class AuthViewImp: UIView, AuthView {
    var registrationAction: (() -> Void)?

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var helloView: UIView!
    @IBOutlet weak var hellolabel: UILabel!

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var registrationButton: CustomButton!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func update(with data: AuthViewData) {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        addGestureRecognizer(recognizer)

        scrollView.keyboardDismissMode = .onDrag
        hellolabel.text = data.loginTextFieldPlaceholder

        helloView.layer.shadowColor = UIColor.black.cgColor
        helloView.layer.shadowOpacity = 0.25
        helloView.layer.shadowOffset = CGSize(width: 0, height: 8)
        helloView.layer.shadowRadius = 10

        loginTextField.backgroundColor = .white.withAlphaComponent(0.6)
        loginTextField.layer.cornerRadius = 15
        loginTextField.layer.masksToBounds = true

        passwordTextField.backgroundColor = .white.withAlphaComponent(0.6)
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.masksToBounds = true

        makeButton(button: loginButton)
        makeButton(button: registrationButton)

        NotificationCenter.default.addObserver(
            self,
        selector: #selector(keyboardWillShow),
        name: UIResponder.keyboardWillShowNotification,
        object: nil
        )

        NotificationCenter.default.addObserver(
            self,
        selector: #selector(keyboardWillHide),
        name: UIResponder.keyboardWillHideNotification,
        object: nil
        )
    }

    // MARK: - Actions

    @IBAction func loginButtonDidTap(sender: UIButton) {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
//        endEditing(true)
    }

    @IBAction func registrationButtonDidTap(sender: UIButton) {
        registrationAction?()
    }

    @objc
    private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardHeihgt = keyboardFrame.cgRectValue.height
        scrollView.contentInset.bottom = keyboardHeihgt + 15
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeihgt
    }

    @objc
    private func closeKeyboard() {
        endEditing(true)
    }

    @objc
    private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = .zero
    }

    // MARK: - Private methods

        private func makeButton(button: CustomButton) {
            button.normalColor = UIColor(named: "VelvetBlue") ?? .white
            button.highlightColor = .white
            button.layer.cornerRadius = 10
            button.layer.borderColor = UIColor(named: "DarkBlue")?.withAlphaComponent(0.22).cgColor
            button.layer.borderWidth = 1
            button.layer.shadowOpacity = 0.25
            button.layer.shadowOffset = CGSize(width: 0, height: 4)
            button.layer.shadowRadius = 4
        }
}
