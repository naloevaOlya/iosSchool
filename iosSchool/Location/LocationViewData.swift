//
//  LocationViewData.swift
//  iosSchool
//
//  Created by student2 on 14.04.2023.
//

import Foundation

struct LocationViewData {
    let cellVM: [LocationCellData]

    init(cells: [LocationCellData]) {
        cellVM = cells
    }
}
