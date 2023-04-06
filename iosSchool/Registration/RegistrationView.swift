//
//  RegistrationView.swift
//  iosSchool
//
//  Created by student2 on 25.03.2023.
//

import UIKit

protocol RegistrationView: UIView {
    func update(with data: RegistrationViewData)
}

class RegistrationViewImp: UIView, RegistrationView {

    @IBOutlet weak var regLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var backButton: CustomButton!
    @IBOutlet weak var doneButton: CustomButton!

    func update(with data: RegistrationViewData) {
        regLabel.text = data.registrationTextFieldPlaceholder

        loginTextField.backgroundColor = .white.withAlphaComponent(0.6)
        loginTextField.layer.cornerRadius = 15
        loginTextField.layer.masksToBounds = true

        passwordTextField.backgroundColor = .white.withAlphaComponent(0.6)
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.masksToBounds = true

        repeatPasswordTextField.backgroundColor = .white.withAlphaComponent(0.6)
        repeatPasswordTextField.layer.cornerRadius = 15
        repeatPasswordTextField.layer.masksToBounds = true

        makeButton(button: backButton)
        makeButton(button: doneButton)
    }

    // MARK: - Actions

    @IBAction func backButtonDidTap(sender: UIButton) {

    }

    @IBAction func doneButtonDidTap(sender: UIButton) {
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
