//
//  AuthViewController.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import UIKit

class AuthViewController<View: AuthView>: BaseViewController<View> {

    var onOpenRegistration: (() -> Void)?

    private let dataProvider: AuthDataProvider

    init(dataProvider: AuthDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented ")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.update(with: AuthViewData())
        rootView.registrationAction = onOpenRegistration
//        dataProvider.autorization(usernamee: "buba", password: "1111") { result in
//                switch result {
//                case .success(let success):
//                    print(success)
//                case .failure(let failure):
//                    print(failure.rawValue)
//                }
//            }
    }

}
