//
//  ProfileView.swift
//  iosSchool
//
//  Created by student2 on 20.04.2023.
//

import UIKit

protocol ProfileView: UIView {
    var exitButtonAction: (() -> Void)? { get set }
    func makeView()
    func update(data: ProfileCellsData)
}

protocol ProfileViewDelegate: AnyObject {
    func saveColor(color: UIColor)
    func getSavedColor() -> UIColor?
    func setPhotoFromAlbum()
    func deletePhoto()
}

class ProfileViewImp: UIView, ProfileView {
    var exitButtonAction: (() -> Void)?

    private var profileData: ProfileCellsData?
    private let tableView = UITableView()
    private let exitButton = CustomButton()
    private var profileColor = UIColor()
    weak var delegate: ProfileViewDelegate?

    func makeView() {
        profileColor = delegate?.getSavedColor() ?? UIColor(named: "Lillac80")?.withAlphaComponent(1.06) ?? .white
        backgroundColor = profileColor
        makeButton(button: exitButton)
        makeTable(table: tableView)
    }

    func update(data: ProfileCellsData) {
        profileData = data
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    @objc func exitButtonDidTap(_ sender: CustomButton) {
        exitButtonAction?()
    }

    // MARK: - Private methods

    private func makeTable(table: UITableView) {
        table.backgroundColor = .clear
        addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.contentInsetAdjustmentBehavior = .never

        let firstCell = UINib(nibName: ProfilePhotoCell.className, bundle: nil)
        table.register(firstCell, forCellReuseIdentifier: ProfilePhotoCell.className)

        let secondCell = UINib(nibName: ProfileUserNameCell.className, bundle: nil)
        table.register(secondCell, forCellReuseIdentifier: ProfileUserNameCell.className)

        let thirdCell = UINib(nibName: ProfileDateColorCell.className, bundle: nil)
        table.register(thirdCell, forCellReuseIdentifier: ProfileDateColorCell.className)

        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: topAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        table.bottomAnchor.constraint(greaterThanOrEqualTo: exitButton.topAnchor, constant: 15).isActive = true
        table.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    private func makeButton(button: CustomButton) {
        button.backgroundColor = UIColor(named: "VelvetBlue") ?? .white
        button.normalColor = UIColor(named: "VelvetBlue") ?? .white
        button.highlightColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor(named: "DarkBlue")?.withAlphaComponent(0.22).cgColor
        button.layer.borderWidth = 1
        button.layer.shadowOpacity = 0.25
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.addTarget(self, action: #selector(exitButtonDidTap(_ :)), for: .touchUpInside)
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

// MARK: - Table View DataSource

extension ProfileViewImp: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let profileData, let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfilePhotoCell.className,
                for: indexPath
            ) as? ProfilePhotoCell {
                cell.setSetting(color: profileColor)
                cell.viewModel = profileData
                cell.delegate = self
                return cell
            }
        case 1:
            if let profileData, let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileUserNameCell.className,
                for: indexPath
            ) as? ProfileUserNameCell {
                cell.setSetting(color: profileColor)
                cell.viewModel = profileData
                return cell
            }
        case 2:
            if let profileData, let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileDateColorCell.className,
                for: indexPath
            ) as? ProfileDateColorCell {
                cell.delegate = self
                cell.setSetting(color: profileColor)
                cell.viewModel = profileData
                return cell
            }
        case 3:
            if let profileData, let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileDateColorCell.className,
                for: indexPath
            ) as? ProfileDateColorCell {
                cell.delegate = self
                cell.setSetting(color: profileColor)
                cell.viewModel = profileData
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}

// MARK: - Table View Delegate

extension ProfileViewImp: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
            return 123
        case 3:
            return 58
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - Profile Date Color Cell Delegate

extension ProfileViewImp: ProfileDateColorCellDelegate {
    func getIndexOfRow(cell: UITableViewCell) -> Int {
        tableView.indexPath(for: cell)?.row ?? 0
    }

    func colorWasChanged(color: UIColor?) {
        guard let color, let index = tableView.indexPathsForVisibleRows else {
            return
        }
        backgroundColor = color
        profileColor = color
        tableView.reloadRows(at: index, with: .fade)
        delegate?.saveColor(color: color)
    }
}

// MARK: - Profle Photo Cell Delegate

extension ProfileViewImp: ProfilePhotoCellDelegate {
    func pickerIsActive() {
        delegate?.setPhotoFromAlbum()
    }

    func deletePhoto() {
        delegate?.deletePhoto()
    }
}
