//
//  RegistrationDataProvider.swift
//  iosSchool
//
//  Created by student2 on 25.03.2023.
//

import Foundation

protocol RegistrationDataProvider {
    func registration(
        username: String,
        password: String,
        completion: @escaping (Result<TokenResponse, ApiError>) -> Void
    )
}

class RegistrationDataProviderImp: RegistrationDataProvider {
    private let apiClient: RegistrationApiClient

    init(apiClient: RegistrationApiClient) {
        self.apiClient = apiClient
    }

    func registration(
        username: String,
        password: String,
        completion: @escaping (Result<TokenResponse, ApiError>) -> Void
    ) {
        apiClient.registration(username: username, password: password) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let data):
                completion(.failure(data))
            }
        }
    }
}
