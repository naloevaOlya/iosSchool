//
//  PrivateViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func saveColor(color: UIColor)
    func getSavedColor() -> UIColor?
}

class ProfileViewController<View: ProfileViewImp>: BaseViewController<View> {
    private var storageManager: StorageManager
    var exitButtonDidTap: (() -> Void)?

    init(storageManager: StorageManager, exitButtonDidTap: (() -> Void)?) {
        self.storageManager = storageManager
        self.exitButtonDidTap = exitButtonDidTap
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.delegate = self
        let data = setData()
        rootView.makeView()
        rootView.update(data: ProfileViewData(data: data))
        rootView.exitButtonAction = exitButtonDidTap
    }

    private func setData() -> ProfileCellsData {
        ProfileCellsData(
            backPhoto: nil,
            circlePhoto: nil,
            userName: storageManager.getUserName().isEmpty ? nil : storageManager.getUserName(),
            date: storageManager.getAppLaunchDate().isEmpty ? nil : storageManager.getAppLaunchDate()
        )
    }
}

extension ProfileViewController: ProfileViewDelegate {
    func saveColor(color: UIColor) {
        storageManager.saveProfileColor(color: color)
    }

    func getSavedColor() -> UIColor? {
        storageManager.getProfileColor()
    }
}
