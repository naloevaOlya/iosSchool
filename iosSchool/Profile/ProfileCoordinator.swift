//
//  ProfileCoordinator.swift
//  iosSchool
//
//  Created by student2 on 10.04.2023.

//

import UIKit

class ProfileCoordinator: BaseCoordinator<ProfileCoordinator.Context> {

    struct Context {
        let exitButtonDidTap: (() -> Void)?
    }

    override func make() -> UIViewController {
        let controller = assembly.profileVC(exitButtonDidTap: context.exitButtonDidTap)
        return controller
    }
}
