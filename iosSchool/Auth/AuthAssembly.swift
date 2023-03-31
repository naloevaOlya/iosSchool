//
//  AuthAssembly.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import Foundation

protocol AuthAssembly {
    func authCoordinator() -> AuthCoordinator
    func authVC() -> AuthViewController
    func authDataProvider() -> AuthDataProvider
}

extension Assembly: AuthAssembly {

    func authCoordinator() -> AuthCoordinator {
        AuthCoordinator(assembly: self, context: .init())
    }

    func authVC() -> AuthViewController {
        .init(dataProvider: authDataProvider())
    }

    func authDataProvider() -> AuthDataProvider {
        AuthDataProviderImp(apiClient: apiClient)
    }
}
