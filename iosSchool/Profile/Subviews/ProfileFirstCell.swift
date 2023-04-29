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
        let img  = viewModel.photo
        let imgSize = CGSize(width: 110, height: 110)
        let imgWithBorder = UIGraphicsImageRenderer(size: imgSize).image { _ in
            let imgFrame = CGRect(origin: .zero, size: imgSize)
            let circle = UIBezierPath(ovalIn: imgFrame)
            circle.addClip()
            img?.draw(in: imgFrame)
            circle.lineWidth = 5
            UIColor(named: "cellColor")?.withAlphaComponent(0.7).setStroke()
            circle.stroke()
        }
        userLogoImageView.image = imgWithBorder
    }
}
