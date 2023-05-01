//
//  LocationViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit
import SPIndicator
import PKHUD

class LocationViewController <View: LocationView>: BaseViewController<View> {

    private var profileDataProvider: ProfileDataProvider
    private let dataProvider: LocationDataProvider
    private var storageManager: StorageManager

    var selectLocation: ((LocationCellData) -> Void)?
    var page: Int = 1
    var cellsVM: [LocationCellData] = []
    var pagesLimited: Bool = false

    init(profileDataProvider: ProfileDataProvider, dataProvider: LocationDataProvider, storageManager: StorageManager) {
        self.profileDataProvider = profileDataProvider
        self.dataProvider = dataProvider
        self.storageManager = storageManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented ")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBar()

        let token = self.storageManager.getToken()
        self.getProfile(userld: token?.userId ?? "")

        rootView.selectLocation = selectLocation
        rootView.willDisplay = { [weak self] result in
            guard let self,
                  self.cellsVM.count > 0,
                  self.cellsVM.count / 2 == result.row
            else {
                return
            }
            self.loadPage(self.page)
        }
        rootView.makeView()
        HUD.show(.progress)
        loadPage(page)
    }

// MARK: - Action

    @objc
    private func reload() {
        page = 1
        cellsVM = []
        rootView.update(data: .init(cells: cellsVM))
        pagesLimited = false
        HUD.show(.progress)
        loadPage(page)
    }

// MARK: - Private

    private func getProfile(userld: String) {
        HUD.show(.progress)
        profileDataProvider.getProfile(profileId: userld) { result in
            DispatchQueue.main.async {
                HUD.hide()
            }
            switch result {
            case .success(let data):
                self.storageManager.saveUserName(username: data.username)
            case .failure(let data):
                print(data.rawValue)
            }
        }
    }

    private func loadPage(_ page: Int) {
        guard !pagesLimited else {
            return
        }
        dataProvider.getLocationFromPage(page: page) { [weak self]  result in
            guard let self else {
                return
            }
            DispatchQueue.main.async {
                HUD.hide()
            }

            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let newCells = data.results.map { LocationCellData(
                        location: $0,
                        population: "Население: \($0.residents.count)"
                    )}
                    self.cellsVM.append(contentsOf: newCells)
                    self.rootView.update(data: .init(cells: self.cellsVM))
                    self.pagesLimited = self.page == data.info.pages
                    if self.page < data.info.pages {
                        self.page += 1
                    }
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    SPIndicator.present(title: failure.rawValue, preset: .error, haptic: .error)
                }
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
