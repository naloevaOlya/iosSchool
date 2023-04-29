//
//  ProfileAssembly.swift
//  iosSchool
//
//  Created by student2 on 10.04.2023.
//

import UIKit

protocol ProfileAssembly {
    func profileCoodrinator() -> ProfileCoordinator
    func profileVC() -> ProfileViewController<ProfileViewImp>
}

extension Assembly: ProfileAssembly {

    func profileCoodrinator() -> ProfileCoordinator {
        ProfileCoordinator(assembly: self, context: .init())
    }

    func profileVC() -> ProfileViewController<ProfileViewImp> {
        .init(data: ProfileCellsData.init(
            photo: nil,
            userName: nil,
            date: nil
        ))
    }
}
