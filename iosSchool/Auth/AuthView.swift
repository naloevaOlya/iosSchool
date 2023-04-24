//
//  AuthView.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import UIKit

protocol AuthView: UIView {
    var registrationAction: (() -> Void)? { get set }
    var delegate: AuthViewDelegate? { get set }

    func update(with data: AuthViewData)
}

protocol AuthViewDelegate: AnyObject {
    func loginButtonDidTap(login: String, password: String)
}

class AuthViewImp: UIView, AuthView {
    var registrationAction: (() -> Void)?
    weak var delegate: AuthViewDelegate?
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

        helloView.layer.shadowColor = UIColor.black.cgColor
        helloView.layer.shadowOpacity = 0.25
        helloView.layer.shadowOffset = CGSize(width: 0, height: 8)
        helloView.layer.shadowRadius = 10

        makeTextField(textField: loginTextField)
        makeTextField(textField: passwordTextField)

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
        endEditing(true)
        delegate?.loginButtonDidTap(
            login: loginTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
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
        scrollView.contentInset.bottom = keyboardHeihgt
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
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor(named: "DarkBlue")?.withAlphaComponent(0.22).cgColor
        button.layer.borderWidth = 1
        button.layer.shadowOpacity = 0.25
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
    }

    private func makeTextField(textField: UITextField) {
        textField.backgroundColor = .white.withAlphaComponent(0.6)
        textField.layer.cornerRadius = 15
        textField.layer.masksToBounds = true
    }
}

// MARK: - UITextFieldDelegate

extension AuthViewImp: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}
