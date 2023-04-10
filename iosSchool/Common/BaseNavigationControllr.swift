//
//  BaseNavigationController.swift
//  iosSchool
//
//  Created by student2 on 10.04.2023.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.prefersLargeTitles = false
        navigationBar.isTranslucent = false
    }

    override var childForStatusBarStyle: UIViewController? {
        topViewController
    }
}
