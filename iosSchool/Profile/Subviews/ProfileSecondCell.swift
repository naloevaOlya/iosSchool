//
//  ProfileSecondCell.swift
//  iosSchool
//
//  Created by student2 on 20.04.2023.
//

import UIKit

class ProfileSecondCell: UITableViewCell {

    override func prepareForReuse() {
         super.prepareForReuse()
         self.accessoryType = .none
     }
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
        userNameLabel.text = viewModel.userName
    }
}
