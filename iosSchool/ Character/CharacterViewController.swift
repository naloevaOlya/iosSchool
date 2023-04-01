//
//  CharacterViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit

class CharacterViewController: UIViewController {
    private let dataProvider: CharacterDataProvider

    init(dataProvider: CharacterDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented ")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
