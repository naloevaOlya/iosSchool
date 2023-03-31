//
//  Assembly.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import Foundation

class Assembly {

    var apiClient: ApiClient {
        ApiClient()
    }

    func colorGenerator(alpha: Double) -> ColorGenerator {
        colorGenerator(alpha: alpha)
    }

    func appCoordinator() -> AppCoordinator {
        AppCoordinator(assembly: self, context: CoordinatorContext())
       // AppCoordinator(assembly: self, context: .init())
    }
}
