//
//  RegistrationCoordinator.swift
//  iosSchool
//
//  Created by student2 on 25.03.2023.
//

import UIKit

class RegistrationCoordinator: BaseCoordinator<RegistrationCoordinator.Context> {

    struct Context {
        let onRegistrationSuccess: (() -> Void)?
    }

    override func make() -> UIViewController {
        let controller = assembly.registrationVC(onRegistrationSuccess: context.onRegistrationSuccess)
        controller.onOpenTabBar = { [weak controller] in
            let coordinator = self.assembly.locationCoordinator()
            let tabBarVC = coordinator.make()
            controller?.present(tabBarVC, animated: true)
        }
        return controller
    }
}
