//
//  Location.swift
//  iosSchool
//
//  Created by student2 on 27.03.2023.
//

import Foundation

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let residents: [String]
    let dim: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case residents
        case dim = "dimension"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = (try? container.decode(String.self, forKey: .type)) ?? "no type"
        residents = try container.decode([String].self, forKey: .residents)
        dim = try container.decode(String.self, forKey: .dim)
    }
}

struct LocationsList: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    let info: Info
    let results: [Location]
}
