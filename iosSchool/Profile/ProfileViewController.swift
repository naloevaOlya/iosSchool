//
//  PrivateViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit

class ProfileViewController <View: ProfileViewImp>: BaseViewController<View> {
    private var data: ProfileCellsData

    init(data: ProfileCellsData) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.makeView()
        rootView.update(data: ProfileViewData(data: data))
    }
}
