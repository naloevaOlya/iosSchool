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
        return controller
    }

}
