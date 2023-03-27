//
//  AuthApiClient.swift
//  iosSchool
//
//  Created by student2 on 27.03.2023.
//

import Foundation

protocol AuthApiClient {
    func autorization(
        username: String,
        password: String,
        onRequeestCompleted: @escaping (Result<TokenResponse, ApiError>) -> Void
    )
}

extension ApiClient: AuthApiClient {
    func autorization (
        username: String,
        password: String,
        onRequeestCompleted: @escaping (Result<TokenResponse, ApiError>) -> Void
    ) {
        let url = NetworkConstants.URLStrings.nanoPost +
        "/auth/login?username=\(username)&password=\(password)"
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequeestCompleted)
    }
}
