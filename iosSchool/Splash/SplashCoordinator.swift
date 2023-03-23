//
//  SplashCoordinator.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import UIKit

class SplashCoordinator: BaseCoordinator<SplashCoordinator.Context> {
    struct Context {}

    override func make() -> UIViewController {
        let controller = assembly.splashVC()
        return controller
    }
}
