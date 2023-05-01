//
//  RegistrationView.swift
//  iosSchool
//
//  Created by student2 on 25.03.2023.
//

import UIKit

protocol RegistrationView: UIView {
    var tabBarAction: (() -> Void)? { get set }
    var delegate: RegistrationViewDelegate? { get set }
    func update(with data: RegistrationViewData)
}

protocol RegistrationViewDelegate: AnyObject {
    func doneButtonDidTap(login: String, password: String, repeatPassword: String)
    func backButtonDidTap()
}

class RegistrationViewImp: UIView, RegistrationView {
    var tabBarAction: (() -> Void)?
    weak var delegate: RegistrationViewDelegate?
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var regLabel: UILabel!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var repeatPasswordTextField: UITextField!
    @IBOutlet private weak var doneButton: CustomButton!
    @IBOutlet private weak var backButton: CustomButton!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func update(with data: RegistrationViewData) {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        addGestureRecognizer(recognizer)

        makeTextField(textField: loginTextField)
        makeTextField(textField: passwordTextField)
        makeTextField(textField: repeatPasswordTextField)
        makeButton(button: doneButton)
        makeButton(button: backButton)

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

    @IBAction func backButtonDidTap(sender: UIButton) {
        endEditing(true)
        delegate?.backButtonDidTap()
    }

    @IBAction func doneButtonDidTap(sender: UIButton) {
        endEditing(true)
        delegate?.doneButtonDidTap(
            login: loginTextField.text ?? "",
            password: passwordTextField.text ?? "",
            repeatPassword: repeatPasswordTextField.text ?? ""
        )
        tabBarAction?()
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
        textField.delegate = self
    }
}

    // MARK: - UITextFieldDelegate

extension RegistrationViewImp: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            repeatPasswordTextField.becomeFirstResponder()
        } else {
            repeatPasswordTextField.resignFirstResponder()
        }
        return true
    }
}
