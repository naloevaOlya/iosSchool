//
//  BaseCoordinator.swift
//  iosSchool
//
//  Created by student2 on 20.03.2023.
//

import UIKit

class  BaseCoordinator<Context> {
    let assembly: Assembly
    let context: Context

    init(assembly: Assembly, context: Context) {
        self.assembly = assembly
        self.context = context
    }

    func make() -> UIViewController {
        fatalError("This method is abstract")
    }

}
