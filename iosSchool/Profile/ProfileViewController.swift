//
//  PrivateViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    func startAuth()
}

class ProfileViewController<View: ProfileViewImp>: BaseViewController<View> {
    private var storageManager: StorageManager
    weak var delegate: ProfileViewControllerDelegate?

    init(storageManager: StorageManager) {
        self.storageManager = storageManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let data = setData()
        rootView.delegate = self
        rootView.makeView()
        rootView.update(data: ProfileViewData(data: data))
    }

    private func setData() -> ProfileCellsData {
        return ProfileCellsData(
            backPhoto: nil,
            circlePhoto: nil,
            userName: storageManager.getUserName() == "" ? nil : storageManager.getUserName(),
            date: storageManager.getAppLaunchDate() == "" ? nil : storageManager.getAppLaunchDate()
        )
    }
}

extension ProfileViewController: ProfileViewDelegate {
    func exitButtonDidTap() {
        print("in profile VC - delete")
        storageManager.cleanindKeychainIfNeedIt()
        storageManager.removeToken()
        storageManager.cleanUserDefaults()
        delegate?.startAuth()
    }
}
