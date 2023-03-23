//
//  SplashViewController.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import UIKit

class SplashViewController: UIViewController {
    private let dataProvider: SplashDataProvider

    init(dataProvider: SplashDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
