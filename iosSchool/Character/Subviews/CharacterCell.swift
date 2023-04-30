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
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var activeView: UIActivityIndicatorView!

    private func update(viewModel: CharacterCellData?) {
        guard let viewModel else {
            return
        }
        layer.cornerRadius = 15
        activeView.layer.cornerRadius = 30
        if viewModel.isLoading {
            activeView.startAnimating()
            imageView.image = UIImage(named: "character-placeholder")
        } else {
            activeView.stopAnimating()
            imageView.image = viewModel.image
        }
        nameLabel.text = viewModel.name
        typeLabel.text = viewModel.type
    }
}
