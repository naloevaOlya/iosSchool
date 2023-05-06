//
//  RegistrationAssembly.swift
//  iosSchool
//
//  Created by student2 on 25.03.2023.
//

import Foundation

protocol RegistrationAssembly {
    func registrationCoordinator(onRegistrationSuccess: (() -> Void)?) -> RegistrationCoordinator
    func registrationVC(onRegistrationSuccess: (() -> Void)?) -> RegistrationViewController<RegistrationViewImp>
    func registrationDataProvider() -> RegistrationDataProvider
}

extension Assembly: RegistrationAssembly {
    func registrationCoordinator(onRegistrationSuccess: (() -> Void)?) -> RegistrationCoordinator {
        RegistrationCoordinator(assembly: self, context: .init(onRegistrationSuccess: onRegistrationSuccess))
    }

    func registrationVC(
        onRegistrationSuccess: (() -> Void)?
    ) -> RegistrationViewController<RegistrationViewImp> {
        .init(
            dataProvider: registrationDataProvider(),
            storageManager: storageManager,
            onRegistrationSuccess: onRegistrationSuccess
        )
    }

    func registrationDataProvider() -> RegistrationDataProvider {
        RegistrationDataProviderImp(apiClient: apiClient)
    }
}
