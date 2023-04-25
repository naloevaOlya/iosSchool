//
//  ProfileThirdCell.swift
//  iosSchool
//
//  Created by student2 on 20.04.2023.
//

import UIKit

class ProfileThirdCell: UITableViewCell {

    override func prepareForReuse() {
         super.prepareForReuse()
         self.accessoryType = .none
     }

    var viewModel: ProfileCellsData? {
        didSet {
            update(viewModel)
        }
    }

    private var cellView = UIView()
    private var leftLabel = UILabel()
    private var rightView = UIView()

    private var dateLabel = UILabel()

    func makeDateCell() {
        heightAnchor.constraint(equalToConstant: 123).isActive = true
        setCellView()
        setImage()
        setLeftLabel(labelText: "Дата регистрации")
        setRightView()
        dateLabel.textColor = UIColor(named: "CustomGrey") ?? .black
        dateLabel.font = dateLabel.font.withSize(16)
        rightView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: rightView.topAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: rightView.leadingAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: rightView.bottomAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: rightView.trailingAnchor).isActive = true
    }

    func makeColorCell() {
        self.heightAnchor.constraint(equalToConstant: 58).isActive = true
        setCellView()
        setImage()
        setLeftLabel(labelText: "Цвет профиля")
        setRightView()
        let color = UIColorWell()
        rightView.addSubview(color)
        color.translatesAutoresizingMaskIntoConstraints = false
        color.topAnchor.constraint(equalTo: rightView.topAnchor).isActive = true
        color.leadingAnchor.constraint(equalTo: rightView.leadingAnchor).isActive = true
        color.bottomAnchor.constraint(equalTo: rightView.bottomAnchor).isActive = true
        color.trailingAnchor.constraint(equalTo: rightView.trailingAnchor).isActive = true
    }

    // MARK: - Private Methods

    private func update(_ viewModel: ProfileCellsData?) {
        guard let viewModel else {
            return
        }
        dateLabel.text = viewModel.date
    }

    private func setCellView() {
        addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
        cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        cellView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func setImage() {
        let img = UIImageView()
        img.image = UIImage(named: "profile-labelImage")
        cellView.addSubview(img)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        img.leadingAnchor.constraint(equalTo: cellView.leadingAnchor).isActive = true
        img.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        img.trailingAnchor.constraint(equalTo: cellView.trailingAnchor).isActive = true
        img.contentMode = .scaleAspectFill
    }

    private func setLeftLabel(labelText: String) {
        leftLabel.textColor = UIColor(named: "CustomGrey") ?? .black
        leftLabel.font = leftLabel.font.withSize(16)
        leftLabel.text = labelText
        cellView.addSubview(leftLabel)
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        leftLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16).isActive = true
        leftLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10).isActive = true
    }

    private func setRightView() {
        rightView.backgroundColor = .clear
        cellView.addSubview(rightView)
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        rightView.leadingAnchor.constraint(greaterThanOrEqualTo: leftLabel.leadingAnchor, constant: 15).isActive = true
        rightView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8).isActive = true
        rightView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16).isActive = true
    }
}
