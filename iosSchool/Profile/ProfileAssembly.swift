//
//  ProfileAssembly.swift
//  iosSchool
//
//  Created by student2 on 10.04.2023.
//

import UIKit

protocol ProfileAssembly {
    func profileCoodrinator(exitButtonDidTap: (() -> Void)?) -> ProfileCoordinator
    func profileVC(exitButtonDidTap: (() -> Void)?) -> ProfileViewController<ProfileViewImp>
    func profileDataProvider() -> ProfileDataProvider
}

extension Assembly: ProfileAssembly {

    func profileCoodrinator(exitButtonDidTap: (() -> Void)?) -> ProfileCoordinator {
        ProfileCoordinator(assembly: self, context: .init(exitButtonDidTap: exitButtonDidTap))
    }

    func profileVC(exitButtonDidTap: (() -> Void)?) -> ProfileViewController<ProfileViewImp> {
        .init(
            storageManager: storageManager,
            exitButtonDidTap: exitButtonDidTap
        )
    }
}
