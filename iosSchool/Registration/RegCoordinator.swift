//
//  RegCoordinator.swift
//  iosSchool
//
//  Created by student2 on 25.03.2023.
//

import UIKit

class RegCoordinator: BaseCoordinator<RegCoordinator.Context> {

    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.regVC()
        return controller
    }

}
