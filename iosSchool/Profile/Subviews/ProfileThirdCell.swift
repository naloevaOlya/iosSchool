//
//  ProfileThirdCell.swift
//  iosSchool
//
//  Created by student2 on 20.04.2023.
//

import UIKit

class ProfileThirdCell: UITableViewCell {
    var viewModel: ProfileCellsData? {
        didSet {
            update(viewModel)
        }
    }

    weak var delegate: ProfileThirdCellDelegate?

    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var leftLabel: UILabel!
    @IBOutlet private weak  var rightView: UIStackView!

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var color: UIColorWell!

    // MARK: - Private Methods

    private func update(_ viewModel: ProfileCellsData?) {
        guard let viewModel, let index = delegate?.getIndexOfRow(cell: self) else {
            return
        }
        setLabel(label: dateLabel, labelText: viewModel.date ?? ".. .. ....")
        setCellView()
        if index == 2 {
            setLabel(label: leftLabel, labelText: "Дата регистрации")
            rightView.subviews[1].isHidden = true
            rightView.subviews[0].isHidden = false
        } else if index == 3 {
            setLabel(label: leftLabel, labelText: "Цвет профиля")
            rightView.subviews[0].isHidden = true
            rightView.subviews[1].isHidden = false
        }
    }

    private func setCellView() {
        cellView.backgroundColor = UIColor(named: "cellColor") ?? .white
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = (UIColor(named: "cellBorderColor") ?? .gray).cgColor
        cellView.layer.cornerRadius = 15
    }

    private func setLabel(label: UILabel, labelText: String) {
        label.textColor = UIColor(named: "CustomGrey") ?? .black
        label.font = leftLabel.font.withSize(16)
        label.text = labelText
    }
}
