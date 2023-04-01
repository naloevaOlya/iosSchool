//
//  CharacterDataProvider.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import Foundation

protocol CharacterDataProvider {
    func getCharacter(
        url: String,
        completion: @escaping (Result<TokenResponse, ApiError>) -> Void
    )
}

class CharacterDataProviderImp: CharacterDataProvider {
    private let apiClient: CharacterApiClient

    init(apiClient: CharacterApiClient) {
        self.apiClient = apiClient
    }

    func getCharacter(
        url: String,
        completion: @escaping (Result<TokenResponse, ApiError>) -> Void
    ) {
        apiClient.getCharacter(url: url) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let data):
                completion(.failure(data))
            }
        }
    }
}
