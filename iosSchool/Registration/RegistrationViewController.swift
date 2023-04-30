//
//  RegistrationViewController.swift
//  iosSchool
//
//  Created by student2 on 25.03.2023.
//

import UIKit
import SPIndicator
import PKHUD

class RegistrationViewController<View: RegistrationView>: BaseViewController<View> {

    var onRegistrationSuccess: (() -> Void)?
    var onOpenProfile: (() -> Void)?

    private let dataProvider: RegistrationDataProvider
    private let storageManager: StorageManager

    init(dataProvider: RegistrationDataProvider, storageManager: StorageManager, onRegistrationSuccess: (() -> Void)?) {
        self.dataProvider = dataProvider
        self.onRegistrationSuccess = onRegistrationSuccess
        self.storageManager = storageManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented ")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.update(with: RegistrationViewData())
        rootView.delegate = self
    }

    private func isPasswordsEqual(password: String, repeatPassword: String) -> Bool {
        return password == repeatPassword
    }
}

// MARK: - AuthViewDelegate

extension RegistrationViewController: RegistrationViewDelegate {

    func doneButtonDidTap(login: String, password: String, repeatPassword: String) {
        HUD.show(.progress)
        guard isPasswordsEqual(password: password, repeatPassword: repeatPassword) == true else {
            DispatchQueue.main.async {
                HUD.hide()
                SPIndicator.present(title: "Пароли не совпадают", preset: .error, haptic: .error)
            }
            return
        }
        dataProvider.registration(username: login, password: password) { [weak self] result in
            DispatchQueue.main.async {
                HUD.hide()
            }
            switch result {
            case .success(let token):
                self?.storageManager.saveToken(token: token)
                self?.onRegistrationSuccess?()
                DispatchQueue.main.async {
                    SPIndicator.present(title: "Регистрация прошла успешно", preset: .done, haptic: .success)
                }
            case .failure:
                DispatchQueue.main.async {
                    SPIndicator.present(title: "Ошибка регистрации", preset: .error, haptic: .error)
                }
            }
        }
    }

    func backButtonDidTap() {
        self.dismiss(animated: true)
    }
}
