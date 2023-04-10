//
//  RegistrationAssembly.swift
//  iosSchool
//
//  Created by student2 on 25.03.2023.
//

import Foundation

protocol RegistrationAssembly {
    func registrationCoordinator() -> RegistrationCoordinator
    func registrationVC() -> RegistrationViewController<RegistrationViewImp>
    func registrationDataProvider() -> RegistrationDataProvider
}

extension Assembly: RegistrationAssembly {

    func registrationCoordinator() -> RegistrationCoordinator {
        RegistrationCoordinator(assembly: self, context: .init())
    }

    func registrationVC() -> RegistrationViewController<RegistrationViewImp> {
        .init(dataProvider: registrationDataProvider())
    }

    func registrationDataProvider() -> RegistrationDataProvider {
        RegistrationDataProviderImp(apiClient: apiClient)
    }
}
