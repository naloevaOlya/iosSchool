//
//  LocationApiClient.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import Foundation

protocol LocationApiClient {
    func getLocation(
        id: Int,
        onRequeestCompleted: @escaping (Result<TokenResponse, ApiError>) -> Void
    )

   func getLocationList(
    onRequeestCompleted: @escaping (Result<TokenResponse, ApiError>) -> Void
    )
}

extension ApiClient: LocationApiClient {
    func getLocation (
        id: Int,
        onRequeestCompleted: @escaping (Result<TokenResponse, ApiError>) -> Void
    ) {
        let url = NetworkConstants.URLStrings.locationURL + "/\(id)"
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequeestCompleted)
    }

    func getLocationList(
     onRequeestCompleted: @escaping (Result<TokenResponse, ApiError>) -> Void
    ) {
        let url = NetworkConstants.URLStrings.locationURL
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequeestCompleted)
    }

}
