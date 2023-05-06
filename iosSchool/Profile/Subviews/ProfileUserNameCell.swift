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

    func setSetting(color: UIColor) {
        contentView.backgroundColor = color
    }

    private func update(_ viewModel: ProfileCellsData?) {
        guard let viewModel else {
            return
        }
        userNameLabel.text = viewModel.userName
    }
}
