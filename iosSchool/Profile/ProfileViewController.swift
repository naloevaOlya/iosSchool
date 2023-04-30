//
//  PrivateViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit

class ProfileViewController <View: ProfileViewImp>: BaseViewController<View> {
    private var data: ProfileCellsData
    private var storageManager: StorageManager

    init(data: ProfileCellsData, storageManager: StorageManager) {
        self.data = data
        self.storageManager = storageManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.makeView()
        setData()
        rootView.update(data: ProfileViewData(data: data))
    }

    private func setData() {
        data.date = storageManager.getAppLaunchDate()
        data.userName = storageManager.getUserName()
    }
}
