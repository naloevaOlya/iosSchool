//
//  AuthCoordinator.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import UIKit

class AuthCoordinator: BaseCoordinator<AuthCoordinator.Context> {

    struct Context {
        let onLoginSuccess: (() -> Void)?
    }

    override func make() -> UIViewController {
        let controller = assembly.authVC(onLoginSuccess: context.onLoginSuccess)
        controller.onOpenRegistration = { [weak controller] in
            let coordinator = self.assembly.registrationCoordinator(onRegistrationSuccess: self.context.onLoginSuccess)
            let regVC = coordinator.make()
            regVC.modalPresentationStyle = .fullScreen
            controller?.present(regVC, animated: true)
        }
        return controller
    }
}
