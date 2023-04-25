//
//  ProfileCellsData.swift
//  iosSchool
//
//  Created by student2 on 25.04.2023.
//

import Foundation

struct ProfileCellsData {
    let userName: String
    let date: String
    let color: String

    init(userName: String, date: String, color: String) {
        self.userName = userName
        self.date = date
        self.color = color
    }
}
