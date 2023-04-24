//
//  LocationCellData.swift
//  iosSchool
//
//  Created by student2 on 14.04.2023.
//

import Foundation

struct LocationCellData {
    let name: String
    let type: String
    let population: String
    let residents: [String]

    init(location: Location, population: String!) {
        name = location.name
        type  = location.type
        self.population = population
        residents =  location.residents
    }
}
