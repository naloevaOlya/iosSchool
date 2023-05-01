//
//  ProfileApiClient.swift
//  iosSchool
//
//  Created by student2 on 02.05.2023.
//

import Foundation

protocol ProfileApiClient {
    func getProfile(
        profileId: String,
        onRequestCompleted: @escaping (Result<Profile, ApiError>) -> Void
    )
}

extension ApiClient: ProfileApiClient {
    func getProfile(
        profileId: String,
        onRequestCompleted: @escaping (Result<Profile, ApiError>) -> Void
    ) {
        let url = NetworkConstants.URLStrings.nanoPost +
        "/v1/profile/\(profileId)"
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequestCompleted)
    }
}
