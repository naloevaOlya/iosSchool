//
//  NetworkConstants.swift
//  iosSchool
//
//  Created by student2 on 27.03.2023.
//

import Foundation

struct NetworkConstants {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }

    struct URLStrings {
        static let locationURL = "https://rickandmortyapi.com/api/location"
        static let nanoPost = "https://nanopost.evolitist.com/api"
    }
}
