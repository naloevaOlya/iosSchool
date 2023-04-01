//
//  CharacterAssembly.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import Foundation

protocol CharacterAssembly {
    func characterCoordinator() -> CharacterCoordinator
    func characterVC() -> CharacterViewController
    func characterDataProvider() -> CharacterDataProvider
}

extension Assembly: CharacterAssembly {

    func characterCoordinator() -> CharacterCoordinator {
        CharacterCoordinator(assembly: self, context: .init())
    }

    func characterVC() -> CharacterViewController {
        .init(dataProvider: characterDataProvider())
    }

    func characterDataProvider() -> CharacterDataProvider {
       CharacterDataProviderImp(apiClient: apiClient)
    }
}
