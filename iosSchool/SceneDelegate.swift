//
//  SceneDelegate.swift
//  iosSchool
//
//  Created by student2 on 13.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var appCoordinator: AppCoordinator? = {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.assembly.appCoordinator()
        }
        return nil
    }()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        appCoordinator?.start(window: window)
    }
}
