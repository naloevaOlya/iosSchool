//
//  ProfileSecondCell.swift
//  iosSchool
//
//  Created by student2 on 20.04.2023.
//

import UIKit

class ProfileSecondCell: UITableViewCell {
    
    var viewModel: ProfileCellsData {
        didSet {
            update(viewModel: viewModel)
        }
    }

    @IBOutlet private weak var userNameLabel: UILabel!

    private func update(viewModel: ProfileCellsData) {
        userNameLabel.text = viewModel.userName
    }
}
