//
//  LocationViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit

class LocationViewController <View: LocationView>: BaseViewController<View> {

    var selectLocation: ((LocationCellData) -> Void)?

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
        setupBar()
        rootView.makeView()
        rootView.selectLocation = selectLocation
        reloadData()
    }

// MARK: - Action
    
    @objc
    private func reload() {
        reloadData()
    }

// MARK: - Private

    private func reloadData() {
        dataProvider.getLocationList { result in
            switch result {
            case .success(let success):
                self.rootView.update(data: LocationViewData(location: success))
            case .failure(let failure):
                print(failure.rawValue)
            }
         }
    }

    private func setupBar() {
        self.title = "Выбор планеты"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(named: "DarkBlue") ?? .white,
            .font: UIFont.systemFont(ofSize: 18)
        ]

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "reload"),
            style: .done,
            target: self,
            action: #selector(reload)
        )
    }
}
