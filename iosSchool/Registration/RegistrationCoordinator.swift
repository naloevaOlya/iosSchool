//
//  RegistrationCoordinator.swift
//  iosSchool
//
//  Created by student2 on 25.03.2023.
//

import UIKit

class RegistrationCoordinator: BaseCoordinator<RegistrationCoordinator.Context> {

    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.registrationVC()
        return controller
    }
}
