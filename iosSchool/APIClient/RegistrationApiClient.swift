//
//  RegistrationApiClient.swift
//  iosSchool
//
//  Created by student2 on 30.03.2023.
//

import Foundation

protocol RegistrationApiClient {
    func registration(
        username: String,
        password: String,
        onRequeestCompleted: @escaping (Result<TokenResponse, ApiError>) -> Void
    )
}

extension ApiClient: RegistrationApiClient {
    func registration (
        username: String,
        password: String,
        onRequeestCompleted: @escaping (Result<TokenResponse, ApiError>) -> Void
    ) {
        let url = NetworkConstants.URLStrings.nanoPost + "/auth/register"
        let jsonData = try? JSONSerialization.data(withJSONObject: ["username": username, "password": password])
        performRequest(url: url, data: jsonData, method: .post, onRequestCompleted: onRequeestCompleted)
    }
}
