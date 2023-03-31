//
//  ApiError.swift
//  iosSchool
//
//  Created by student2 on 27.03.2023.
//

import Foundation

enum ApiError: Error {
    case dataParsing
    case serverError
    case `default` (Data?)

    var rawValue: String {
        switch self {
        case .dataParsing:
            return "Parsing error"
        case .serverError:
            return "Server error"
        case let .default(error):
            if let error {
                return String(decoding: error, as: UTF8.self)
            } else {
                return "Unknown error"
            }
        }
    }
}
