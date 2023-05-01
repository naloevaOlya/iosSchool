//
//  AuthViewController.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import UIKit
import SPIndicator
import PKHUD

class AuthViewController<View: AuthView>: BaseViewController<View> {

    var onLoginSuccess: (() -> Void)?
    var onOpenRegistration: (() -> Void)?

    private let dataProvider: AuthDataProvider
    private let storageManager: StorageManager

    init(dataProvider: AuthDataProvider, storaageManager: StorageManager, onLoginSuccess: (() -> Void)?) {
        self.dataProvider = dataProvider
        self.onLoginSuccess = onLoginSuccess
        self.storageManager = storaageManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented ")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.update(with: AuthViewData())
        rootView.registrationAction = onOpenRegistration
        rootView.delegate = self
    }

    private func getProfile(userld: String) {
        dataProvider.getProfile(profileId: userld) { result in
            switch result {
            case .success(let data):
                self.storageManager.saveUserName(username: data.username)
            case .failure(let data):
                print(data.rawValue)
            }
        }
    }
}

// MARK: - AuthViewDelegate

extension AuthViewController: AuthViewDelegate {

    func loginButtonDidTap(login: String, password: String) {
        HUD.show(.progress)
        dataProvider.autorization(usernamee: login, password: password) { [weak self] result in
            DispatchQueue.main.async {
                HUD.hide()
            }
            switch result {
            case .success(let token):
                self?.storageManager.saveToken(token: token)
                self?.onLoginSuccess?()
            case .failure:
                DispatchQueue.main.async {
                    SPIndicator.present(title: "Ошибка авторизации", preset: .error, haptic: .error)
                }
            }
        }
    }
}
