//
//  RootTab.swift
//  iosSchoolHH
//
//  Created by student2 on 01.04.2023.
//

import UIKit

enum RootTab: Int {
    case locations = 0
    case profile

    var tabBarItem: UITabBarItem {
        let tabBarItem = UITabBarItem(
            title: title,
            image: image,
            tag: self.rawValue
        )
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(named: "DarkBlue") ?? .black,
            .font: UIFont.systemFont(ofSize: 10)
        ]
        tabBarItem.standardAppearance = appearance
        return tabBarItem
    }

    private var title: String? {
        switch self {
        case .locations:
            return "Выбор планеты"
        case .profile:
            return "Профиль"
        }
    }

    private var image: UIImage? {
        switch self {
        case .locations:
            return UIImage(named: "planet")?.withRenderingMode(.alwaysOriginal)
        case .profile:
            return UIImage(named: "residents")?.withRenderingMode(.alwaysOriginal)
        }
    }
}
