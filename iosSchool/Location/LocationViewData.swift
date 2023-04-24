//
//  LocationViewData.swift
//  iosSchool
//
//  Created by student2 on 14.04.2023.
//

import Foundation

struct LocationViewData {
    let cellVM: [LocationCellData]

    init(location: LocationsList) {
        cellVM = location.results.map { LocationCellData(
            location: $0,
            population: "naseleenie \($0.residents.count)"
        )}
    }
}
