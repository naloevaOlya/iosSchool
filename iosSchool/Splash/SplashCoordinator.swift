//
//  SplashCoordinator.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import UIKit

class SplashCoordinator: BaseCoordinator<SplashCoordinator.Context> {
    struct Context {
        let onSuccess: (() -> Void)?
    }

    override func make() -> UIViewController {
        let controller = assembly.splashVC(onSuccess: context.onSuccess)
            return controller
        }
    }
