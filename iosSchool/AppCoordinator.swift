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
            self?.startRegistraton()
            // self?.startAuth()
        })
        setRoot(viewController: coordinator.make())
        // setRoot 
    }

    func startAuth() {
        let coordinator = assembly.authCoordinator()
        setRoot(viewController: coordinator.make())
    }

    func startRegistraton() {
        let coordinator = assembly.registrationCoordinator()
        setRoot(viewController: coordinator.make())
    }

    func startLocation() {
        let coordinator = assembly.locationCoordinator()
        setRoot(viewController: coordinator.make())
    }

    func startCharacter() {
        let coordinator = assembly.characterCoordinator()
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
