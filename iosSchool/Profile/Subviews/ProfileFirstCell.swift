//
//  ProfileFirstCell.swift
//  iosSchool
//
//  Created by student2 on 20.04.2023.
//

import UIKit

class ProfileFirstCell: UITableViewCell {

    var viewModel: ProfileCellsData? {
        didSet {
            update(viewModel)
        }
    }

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var userLogoImageView: UIImageView!

    private func update(_ viewModel: ProfileCellsData?) {
        guard let viewModel else {
            return
        }
        profileImageView.image = viewModel.photo
    }
}
