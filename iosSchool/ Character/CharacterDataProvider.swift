//
//  CharacterDataProvider.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import Foundation

protocol CharacterDataProvider {
}

class CharacterDataProviderImp: CharacterDataProvider {
    private let apiClient: CharacterApiClient

    init(apiClient: CharacterApiClient) {
        self.apiClient = apiClient
    }
}
