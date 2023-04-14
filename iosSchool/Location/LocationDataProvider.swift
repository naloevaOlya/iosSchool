//
//  LocationDataProvider.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import Foundation

protocol LocationDataProvider {

    func getLocation(
        id: Int,
        completion: @escaping (Result<Location, ApiError>) -> Void
    )

    func getLocationList(completion: @escaping (Result<LocationsList, ApiError>) -> Void)
}

class LocationDataProviderImp: LocationDataProvider {
    
    private let apiClient: LocationApiClient

    init(apiClient: LocationApiClient) {
        self.apiClient = apiClient
    }

    func getLocation(
        id: Int,
        completion: @escaping (Result<Location, ApiError>) -> Void
    ) {
        apiClient.getLocation(id: id) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let data):
                completion(.failure(data))
            }
        }
    }

    func getLocationList(completion: @escaping (Result<LocationsList, ApiError>) -> Void) {
        apiClient.getLocationList { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let data):
                completion(.failure(data))
            }
        }
    }
}
