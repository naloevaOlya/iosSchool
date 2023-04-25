//
//  PrivateViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit

class ProfileViewController <View: ProfileViewImp>: BaseViewController<View> {
    private var testData: ProfileCellsData

    init(testData: ProfileCellsData) {
        self.testData = testData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setData(date: "24 04 2023", name: "aboba", photo: UIImage(named: "profle-background") ?? nil)
        rootView.makeView()
        rootView.updateData(data: ProfileViewData(data: testData))
    }

    private func setData(date: String, name: String, photo: UIImage?) {
        testData.date = date
        testData.userName = name
        testData.photo = photo
    }
}
