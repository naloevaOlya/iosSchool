//
//  ProfileCellsData.swift
//  iosSchool
//
//  Created by student2 on 25.04.2023.
//

import UIKit

struct ProfileCellsData {
    var photo: UIImage?
    var userName: String?
    var date: String?

    init(photo: UIImage?, userName: String?, date: String?) {
        self.photo = photo
        self.userName = userName
        self.date = date
    }
}
