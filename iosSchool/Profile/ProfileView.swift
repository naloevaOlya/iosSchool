//
//  ProfileView.swift
//  iosSchool
//
//  Created by student2 on 20.04.2023.
//

import UIKit

protocol ProfileThirdCellDelegate: AnyObject {
    func getIndexOfRow(cell: UITableViewCell) -> Int
}

protocol ProfileViewDelegate: AnyObject {
    func exitButtonDidTap()
}

protocol ProfileView: UIView {
    func makeView()
    func update(data: ProfileViewData)
}

class ProfileViewImp: UIView, ProfileView {
    weak var delegate: ProfileViewDelegate?
    private var profileData: ProfileViewData?
    private let tableView = UITableView()
    private let exitButton = CustomButton()

    func makeView() {
        backgroundColor = UIColor(named: "Lillac80")?.withAlphaComponent(1.06) ?? .white
        makeButton(button: exitButton)
        makeTable(table: tableView)
    }

    func update(data: ProfileViewData) {
        profileData = data
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    @objc func exitButtonDidTap(_ sender: CustomButton) {
        print("buton pressed")
        delegate?.exitButtonDidTap()
    }

    // MARK: - Private methods

    private func makeTable(table: UITableView) {
        table.backgroundColor = .clear
        addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.contentInsetAdjustmentBehavior = .never

        let firstCell = UINib(nibName: ProfileFirstCell.className, bundle: nil)
        table.register(firstCell, forCellReuseIdentifier: ProfileFirstCell.className)

        let secondCell = UINib(nibName: ProfileSecondCell.className, bundle: nil)
        table.register(secondCell, forCellReuseIdentifier: ProfileSecondCell.className)

        let thirdCell = UINib(nibName: ProfileThirdCell.className, bundle: nil)
        table.register(thirdCell, forCellReuseIdentifier: ProfileThirdCell.className)

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
                withIdentifier: ProfileFirstCell.className,
                for: indexPath
            ) as? ProfileFirstCell {
                cell.viewModel = profileData.cellVM
                return cell
            }
        case 1:
            if let profileData, let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileSecondCell.className,
                for: indexPath
            ) as? ProfileSecondCell {
                cell.viewModel = profileData.cellVM
                return cell
            }
        case 2:
            if let profileData, let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileThirdCell.className,
                for: indexPath
            ) as? ProfileThirdCell {
                cell.delegate = self
                cell.setCellSetting()
                cell.viewModel = profileData.cellVM
                return cell
            }
        case 3:
            if let profileData, let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileThirdCell.className,
                for: indexPath
            ) as? ProfileThirdCell {
                cell.delegate = self
                cell.setCellSetting()
                cell.viewModel = profileData.cellVM
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

extension ProfileViewImp: ProfileThirdCellDelegate {
    func getIndexOfRow(cell: UITableViewCell) -> Int {
        return tableView.indexPath(for: cell)?.row ?? 0
    }
}
