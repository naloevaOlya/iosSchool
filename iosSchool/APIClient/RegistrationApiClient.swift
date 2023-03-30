//
//  RegistrationApiClient.swift
//  iosSchool
//
//  Created by student2 on 30.03.2023.
//

import Foundation

protocol RegistrationApiClient{
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
        let url = NetworkConstants.URLStrings.nanoPost +
        "/auth/login?username=\(username)&password=\(password)"
        performRequest(url: url, data: nil, method: .post, onRequestCompleted: onRequeestCompleted)
    }
}
