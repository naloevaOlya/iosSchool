//
//  RegistrationViewController.swift
//  iosSchool
//
//  Created by student2 on 25.03.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    private let dataProvider: RegistrationDataProvider

    init(dataProvider: RegistrationDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented ")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        dataProvider.registration(username: "buba", password: "1111") { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.rawValue)
            }
        }
    }
}
