//
//  ProfileDateColorCell.swift
//  iosSchool
//
//  Created by student2 on 20.04.2023.
//

import UIKit

protocol ProfileDateColorCellDelegate: AnyObject {
    func getIndexOfRow(cell: UITableViewCell) -> Int
    func colorWasChanged(color: UIColor?)
}

class ProfileDateColorCell: UITableViewCell {
    var viewModel: ProfileCellsData? {
        didSet {
            update(viewModel)
        }
    }

    weak var delegate: ProfileDateColorCellDelegate?

    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var leftLabel: UILabel!
    @IBOutlet private weak  var rightView: UIStackView!

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var color: UIColorWell!

    func setSetting(color: UIColor) {
        cellView.layer.borderColor = (UIColor(named: "cellBorderColor") ?? .gray).cgColor
        contentView.backgroundColor = color
    }

    @objc func colorChange(_ sender: UIColorWell) {
        delegate?.colorWasChanged(color: sender.selectedColor)
    }

    // MARK: - Private Methods

    private func update(_ viewModel: ProfileCellsData?) {
        guard let viewModel, let index = delegate?.getIndexOfRow(cell: self) else {
            return
        }
        dateLabel.text = viewModel.date
        if index == 2 {
            leftLabel.text = "Дата регистрации"
            dateLabel.isHidden = false
            color.isHidden = true
        } else if index == 3 {
            leftLabel.text = "Цвет профиля"
            color.isHidden = false
            dateLabel.isHidden = true
            color.addTarget(self, action: #selector(colorChange(_ :)), for: .valueChanged)
        }
    }
}
