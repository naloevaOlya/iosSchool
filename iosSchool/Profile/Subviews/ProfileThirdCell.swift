//
//  ProfileThirdCell.swift
//  iosSchool
//
//  Created by student2 on 20.04.2023.
//

import UIKit

class ProfileThirdCell: UITableViewCell {
    @IBOutlet private weak var dateTextField: UITextField!
    @IBOutlet private weak var colorTextField: UITextField!

    func update() {
        colorTextField.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        let image = UIImage(named: "image")
        imageView.image = image
        colorTextField.rightView = imageView
        dateTextField.layer.cornerRadius = 15
        colorTextField.layer.cornerRadius = 15
        dateTextField.backgroundColor = .white.withAlphaComponent(0.6)
        colorTextField.backgroundColor =  .white.withAlphaComponent(0.6)
        dateTextField.layer.masksToBounds = true
        colorTextField.layer.masksToBounds = true
    }
}
