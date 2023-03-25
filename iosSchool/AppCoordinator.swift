//
//  AppCoordinator.swift
//  iosSchool
//
//  Created by student2 on 20.03.2023.
//

import UIKit

struct CoordinatorContext {}

class AppCoordinator: BaseCoordinator<CoordinatorContext> {
    private var window: UIWindow?

    func start(window: UIWindow) {
        self.window = window
        let coordinator = assembly.splashCordinator(onSuccess: {[weak self] in
            self?.startAuth()
            self?.startReg()
        })
        setRoot(viewController: coordinator.make())
    }

    func startAuth() {
        let coordinator = assembly.authCoordinator()
        setRoot(viewController: coordinator.make())
    }

    func startReg() {
        let coordinator = assembly.regCoordinator()
        setRoot(viewController: coordinator.make())
    }

    private func setRoot(viewController: UIViewController?) {
        guard let window, let viewController else {
            return
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
