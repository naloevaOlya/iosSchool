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
        onRequestCompleted: @escaping (Result<Location, ApiError>) -> Void
    )

    func getLocationList(
        onRequestCompleted: @escaping (Result<LocationsList, ApiError>) -> Void
    )

    func getLocationFromPage(
        page: Int,
        onRequestCompleted: @escaping (Result<LocationsList, ApiError>) -> Void
    )
}

extension ApiClient: LocationApiClient {

    func getLocationFromPage(
        page: Int,
        onRequestCompleted: @escaping (Result<LocationsList, ApiError>) -> Void
    ) {
        let url = NetworkConstants.URLStrings.locationURL + "?page=\(page)"
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequestCompleted)
    }

    func getLocation(
        id: Int,
        onRequestCompleted: @escaping (Result<Location, ApiError>) -> Void
    ) {
        let url = NetworkConstants.URLStrings.locationURL + "/\(id)"
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequestCompleted)
    }

    func getLocationList(
        onRequestCompleted: @escaping (Result<LocationsList, ApiError>) -> Void
    ) {
        let url = NetworkConstants.URLStrings.locationURL
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequestCompleted)
    }
}
