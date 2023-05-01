//
//  ProfileCoordinator.swift
//  iosSchool
//
//  Created by student2 on 10.04.2023.

//

import UIKit

class ProfileCoordinator: BaseCoordinator<ProfileCoordinator.Context> {

    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.profileVC()
        controller.delegate = self
        return controller
    }
}

extension ProfileCoordinator: ProfileViewControllerDelegate {
    func startAuth() {
        self.assembly.appCoordinator().startAuth()
    }
}
