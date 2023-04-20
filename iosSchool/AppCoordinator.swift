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
        let coordinator = assembly.splashCordinator(onSuccess: { [weak self] in
            self?.startAuth()
        })
        setRoot(viewController: coordinator.make())
    }

    func startAuth() {
        let coordinator = assembly.authCoordinator { [weak self] in
            DispatchQueue.main.async {
                self?.setTabVC()
            }
        }
        setRoot(viewController: coordinator.make())
    }

    private func setTabVC() {
        let tabVC = assembly.rootTabBarController()
        let locationCoordinator = assembly.locationCoordinator()
        let profileCoordinator = assembly.profileCoodrinator()

        let locationVC = locationCoordinator.make()
        let profiLeVC = profileCoordinator.make()

        let navVC = assembly.rootNavigationController()
        navVC.setViewControllers([locationVC], animated: false)

        navVC.tabBarItem = RootTab.locations.tabBarItem
        profiLeVC.tabBarItem = RootTab.profile.tabBarItem

        tabVC.setViewControllers([navVC, profiLeVC], animated: false)
        setRoot(viewController: tabVC)
    }

    private func setRoot(viewController: UIViewController?) {
        guard let window, let viewController else {
            return
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
