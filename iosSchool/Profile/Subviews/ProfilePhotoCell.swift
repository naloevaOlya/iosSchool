//
//  ProfilePhotoCell.swift
//  iosSchool
//
//  Created by student2 on 20.04.2023.
//

import UIKit

protocol ProfilePhotoCellDelegate: AnyObject {
    func pickerIsActive()
    func deletePhoto()
}

class ProfilePhotoCell: UITableViewCell, UIContextMenuInteractionDelegate {

    var viewModel: ProfileCellsData? {
        didSet {
            update(viewModel)
        }
    }

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var userLogoImageView: UIImageView!
    weak var delegate: ProfilePhotoCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        userLogoImageView.isUserInteractionEnabled = true
        userLogoImageView.addInteraction(UIContextMenuInteraction(delegate: self))
    }

    func contextMenuInteraction(
        _ interaction: UIContextMenuInteraction,
        configurationForMenuAtLocation location: CGPoint
    ) -> UIContextMenuConfiguration? {
        UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let setPhoto = UIAction(title: "Изменить") { _ in
                self.delegate?.pickerIsActive()
            }
            let deletePhoto = UIAction(title: "Удалить", attributes: .destructive) { _ in
                self.delegate?.deletePhoto()
            }
            return UIMenu(title: "Фото профиля", children: [setPhoto, deletePhoto])
        }
    }

    private func update(_ viewModel: ProfileCellsData?) {
        guard let viewModel else {
            return
        }
        contentView.backgroundColor = viewModel.color
        profileImageView.image = viewModel.backPhoto
        userLogoImageView.image = viewModel.circlePhoto
    }
}
