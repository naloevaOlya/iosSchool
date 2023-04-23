//
//  CharacterCell.swift
//  iosSchool
//
//  Created by student2 on 21.04.2023.
//

import UIKit

class CharacterCell: UICollectionViewCell {

    var viewModel: CharacterCellData? {
        didSet {
            update(viewModel: viewModel)
        }
    }

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    private func update(viewModel: CharacterCellData?) {
        guard let viewModel else {
            return
        }
        imageView.image = viewModel.isLoading ? UIImage(named: "character-placeholder") : viewModel.image
        nameLabel.text = viewModel.name
    }
}
