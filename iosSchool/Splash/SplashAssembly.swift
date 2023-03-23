//
//  SplashAssembly.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import UIKit

protocol SplashAssembly {
    func splashCordinator() -> SplashCoordinator
    func splashVC() -> SplashViewController
    func splashDataProvider() -> SplashDataProvider
}

extension Assembly: SplashAssembly {
    func splashCordinator() -> SplashCoordinator {
        .init(assembly: self, context: .init())
    }

    func splashVC() -> SplashViewController {
        .init(dataProvider: splashDataProvider())
    }

    func splashDataProvider() -> SplashDataProvider {
        SplashDataProviderImp()
    }
}
