//
//  Assembly.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import UIKit

class Assembly {

    var apiClient: ApiClient {
        ApiClient()
    }

    lazy var imageService: ImageService = ImageServiceImp(apiClieent: apiClient)

    func appCoordinator() -> AppCoordinator {
        AppCoordinator(assembly: self, context: CoordinatorContext())
    }

    func rootTabBarController() -> UITabBarController {
        TabBarController()
    }

    func rootNavigationController() -> UINavigationController {
        let controller = BaseNavigationController()
        controller.modalPresentationStyle = .fullScreen
        return controller
    }
}
