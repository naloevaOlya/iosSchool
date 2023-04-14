//
//  NSObject+ClaaName.swift
//  iosSchool
//
//  Created by student2 on 14.04.2023.
//

import Foundation

extension NSObject {
    static var classNmae: String {
        String(describing: Self.self)
    }
}
