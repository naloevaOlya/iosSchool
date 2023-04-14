//
//  AuthCoordinator.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import UIKit

class AuthCoordinator: BaseCoordinator<AuthCoordinator.Context> {

    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.authVC()
        controller.onOpenRegistration =  { [ weak controller ] in
            let coordinator = self.assembly.registrationCoordinator { [ self ] }
            let regVC = coordinator.make()
            regVC.modalPresentationStyle = .fullScreen
            controller?.present(regVC, animated: true)
        }
        return controller
    }
}
