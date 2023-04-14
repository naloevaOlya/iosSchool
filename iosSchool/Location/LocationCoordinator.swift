//
//  LocationCoordinator.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit

class LocationCoordinator: BaseCoordinator<LocationCoordinator.Context> {

    struct Context {
    }

    override func make() -> UIViewController {
        let controller = assembly.locationVC()
        controller.selectLocation = { [ weak controller, weak self ] locationVM in
            let coordinator = self?.assembly.characterCoordinator()
            let characterVC = coordinator?.make()
            controller?.navigationController?.pushViewController(characterVC!, animated: true)
        }
        return controller
    }

}
