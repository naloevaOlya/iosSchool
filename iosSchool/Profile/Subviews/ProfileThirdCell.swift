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

    @IBOutlet weak private var cellView: UIView!
    @IBOutlet weak private var leftLabel: UILabel!
    @IBOutlet weak private var rightView: UIStackView!

    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var color: UIColorWell!

    // MARK: - Private Methods

    private func update(_ viewModel: ProfileCellsData?) {
        guard let viewModel, let index = delegate?.getIndexOfRow(cell: self) else {
            return
        }
        dateLabel.text = viewModel.date
        setCellView()
        if index == 2 {
            setLeftLabel(labelText: "Дата регистрации")
            setRightView()
            rightView.subviews[1].isHidden = true
            rightView.subviews[0].isHidden = false
        } else if index == 3 {
            setLeftLabel(labelText: "Цвет профиля")
            setRightView()
            rightView.subviews[0].isHidden = true
            rightView.subviews[1].isHidden = false
        }
    }

    private func setCellView() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
        cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        cellView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cellView.backgroundColor = UIColor(named: "cellColor") ?? .white
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = (UIColor(named: "cellBorderColor") ?? .gray).cgColor
        cellView.layer.cornerRadius = 15
    }

    private func setLeftLabel(labelText: String) {
        leftLabel.textColor = UIColor(named: "CustomGrey") ?? .black
        leftLabel.font = leftLabel.font.withSize(16)
        leftLabel.text = labelText
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        leftLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16).isActive = true
        leftLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10).isActive = true
    }

    private func setRightView() {
        rightView.backgroundColor = .clear
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        rightView.leadingAnchor.constraint(greaterThanOrEqualTo: leftLabel.trailingAnchor, constant: 15).isActive = true
        rightView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10).isActive = true
        rightView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16).isActive = true
        dateLabel.textColor = UIColor(named: "CustomGrey") ?? .black
        dateLabel.font = dateLabel.font.withSize(16)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: rightView.topAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: rightView.leadingAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: rightView.bottomAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: rightView.trailingAnchor).isActive = true
        color.translatesAutoresizingMaskIntoConstraints = false
        color.topAnchor.constraint(equalTo: rightView.topAnchor).isActive = true
        color.leadingAnchor.constraint(equalTo: rightView.leadingAnchor).isActive = true
        color.bottomAnchor.constraint(equalTo: rightView.bottomAnchor).isActive = true
        color.trailingAnchor.constraint(equalTo: rightView.trailingAnchor).isActive = true
    }
}
