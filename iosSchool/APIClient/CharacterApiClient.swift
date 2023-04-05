//
//  CharacterApiClient.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import Foundation

protocol CharacterApiClient {
    func getCharacter(
        url: String,
        onRequestCompleted: @escaping (Result<Character, ApiError>) -> Void
    )
}

extension ApiClient: CharacterApiClient {
    func getCharacter(
        url: String,
        onRequestCompleted: @escaping (Result<Character, ApiError>) -> Void
    ) {
        performRequest(url: url, data: nil, method: .get, onRequestCompleted: onRequestCompleted)
    }

}
