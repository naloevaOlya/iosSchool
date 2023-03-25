//
//  RegAssembly.swift
//  iosSchool
//
//  Created by student2 on 25.03.2023.
//

import Foundation

protocol RegAssembly {
    func regCoordinator() -> RegCoordinator
    func regVC() -> RegViewController
    func regDataProvider() -> RegDataProvider
}

extension Assembly: RegAssembly {

    func regCoordinator() -> RegCoordinator {
        RegCoordinator(assembly: self, context: .init())
    }

    func regVC() -> RegViewController {
        .init(dataProvider: regDataProvider())
    }

    func regDataProvider() -> RegDataProvider {
        RegDataProviderImp()
    }
}
