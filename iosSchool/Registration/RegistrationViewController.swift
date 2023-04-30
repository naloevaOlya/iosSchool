//
//  RegistrationViewController.swift
//  iosSchool
//
//  Created by student2 on 25.03.2023.
//

import UIKit
import SPIndicator

class RegistrationViewController<View: RegistrationView>: BaseViewController<View> {

    var onRegistrationSuccess: (() -> Void)?

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
}

// MARK: - AuthViewDelegate

extension RegistrationViewController: RegistrationViewDelegate {

    func doneButtonDidTap(login: String, password: String, repeatPassword: String) {
        dataProvider.registration(username: login, password: password) { [weak self] result in
                switch result {
                case .success(let token):
                    self?.storageManager.saveToken(token: token)
                    self?.onRegistrationSuccess?()
                case .failure:
                    DispatchQueue.main.async {
                        SPIndicator.present(title: "error registration", preset: .error, haptic: .error)
                    }
                }
            }
    }

    func backButtonDidTap() {
        self.dismiss(animated: true)
    }
}
