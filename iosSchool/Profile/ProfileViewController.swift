//
//  PrivateViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit

class ProfileViewController <View: ProfileView>: BaseViewController<View> {
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.makeView()
    }
}
