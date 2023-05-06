//
//  ProfileUserNameCell.swift
//  iosSchool
//
//  Created by student2 on 20.04.2023.
//

import UIKit

class ProfileUserNameCell: UITableViewCell {

    var viewModel: ProfileCellsData? {
        didSet {
            update(viewModel)
        }
    }

    @IBOutlet private weak var userNameLabel: UILabel!

    private func update(_ viewModel: ProfileCellsData?) {
        guard let viewModel else {
            return
        }
        contentView.backgroundColor = viewModel.color
        userNameLabel.text = viewModel.userName
    }
}
