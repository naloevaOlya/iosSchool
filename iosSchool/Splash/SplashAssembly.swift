//
//  SplashAssembly.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import UIKit

protocol SplashAssembly {
    func splashCordinator(onSuccess: (() -> Void)?) -> SplashCoordinator
    func splashVC(onSuccess: (() -> Void)?) -> SplashViewController
    func splashDataProvider() -> SplashDataProvider
}

extension Assembly: SplashAssembly {
    func splashCordinator(onSuccess: (() -> Void)?) -> SplashCoordinator {
        .init(assembly: self, context: .init(onSuccess: onSuccess))
    }

    func splashVC(onSuccess: (() -> Void)?) -> SplashViewController {
        .init(dataProvider: splashDataProvider(), onSuccess: onSuccess)
    }

    func splashDataProvider() -> SplashDataProvider {
        SplashDataProviderImp()
    }
}
