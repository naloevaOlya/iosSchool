//
//  RegistrationViewController.swift
//  iosSchool
//
//  Created by student2 on 25.03.2023.
//

import UIKit

class RegistrationViewController<View: RegistrationView>: BaseViewController<View> {

    var onRegistrationSuccess: (() -> Void)?

    private let dataProvider: RegistrationDataProvider

    init(dataProvider: RegistrationDataProvider, onRegistrationSuccess: (() -> Void)?) {
        self.dataProvider = dataProvider
        self.onRegistrationSuccess = onRegistrationSuccess
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
            self?.onRegistrationSuccess?()
                switch result {
                case .success(let success):
                    print(success)
                    self?.onRegistrationSuccess?()
                case .failure(let failure):
                    print(failure.rawValue)
                }
            }
    }

    func backButtonDidTap() {
        self.dismiss(animated: true)
    }
}
