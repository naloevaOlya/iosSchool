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
            let coordinator = self.assembly.registrationCoordinator { [weak self] in
                print("onRegisrtationSuccess")
                DispatchQueue.main.async {
                    controller?.dismiss(animated: true)
                    self?.assembly.appCoordinator().setTabVC()
                }
            }
            let regVC = coordinator.make()
            regVC.modalPresentationStyle = .fullScreen
            controller?.present(regVC, animated: true)
        }
        return controller
    }
}
