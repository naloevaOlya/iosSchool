//
//  AuthDataProvider.swift
//  iosSchool
//
//  Created by student2 on 23.03.2023.
//

import Foundation

protocol AuthDataProvider {
    func autorization(
        usernamee: String,
        password: String,
        completion: @escaping (Result<TokenResponse, ApiError>) -> Void
    )
}

class AuthDataProviderImp: AuthDataProvider {
    private let apiClient: AuthApiClient

    init(apiClient: AuthApiClient) {
        self.apiClient = apiClient
    }

    func autorization(
        usernamee: String,
        password: String,
        completion: @escaping (Result<TokenResponse, ApiError>) -> Void
    ) {
        apiClient.autorization(username: usernamee, password: password) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let data):
                completion(.failure(data))
            }
        }
    }
}
