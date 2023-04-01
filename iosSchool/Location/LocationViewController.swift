//
//  LocationViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit

class LocationViewController: UIViewController {
    private let dataProvider: LocationDataProvider

    init(dataProvider: LocationDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented ")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        dataProvider.getLocationList { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.rawValue)
            }
         }
    }
}
