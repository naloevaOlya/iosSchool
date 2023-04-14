//
//  LocationTableViewCell.swift
//  iosSchool
//
//  Created by student2 on 14.04.2023.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    var viewModel: LocationCellData? {
        didSet {
            update(viewModel)
        }
    }

    @IBOutlet private weak var nameLabel: UILabel!

    private func update(_ viewModel: LocationCellData?) {
        guard let viewModel else {
            return
        }
        nameLabel.text = viewModel.name
    }
}
