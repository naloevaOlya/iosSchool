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
        return controller
    }
}
