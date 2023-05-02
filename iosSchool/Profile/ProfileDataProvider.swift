//
//  ProfileDataProvider.swift
//  iosSchool
//
//  Created by student2 on 02.05.2023.
//

import Foundation

protocol ProfileDataProvider {
    func getProfile(
        profileId: String,
        completion: @escaping (Result<Profile, ApiError>) -> Void
    )
}

class ProfileDataProviderImp: ProfileDataProvider {
    private let apiClient: ApiClient

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

    func getProfile(
        profileId: String,
        completion: @escaping (Result<Profile, ApiError>) -> Void
    ) {
        apiClient.getProfile(profileId: profileId) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let data):
                completion(.failure(data))
            }
        }
    }
}
