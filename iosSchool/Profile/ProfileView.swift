//
//  ProfileView.swift
//  iosSchool
//
//  Created by student2 on 20.04.2023.
//

import UIKit

protocol ProfileView: UIView {
    func makeView()
}

class ProfileViewImp: UIView, ProfileView {
    private let tableView = UITableView()
    private let exitButton = CustomButton()

    func makeView() {
        backgroundColor = UIColor(named: "Lillac80")?.withAlphaComponent(1.06) ?? .white
        makeTable(table: tableView)
        makeButton(button: exitButton, table: tableView)
    }

    // MARK: - Private methods

    private func makeTable(table: UITableView) {
        table.backgroundColor = .clear
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none

        let first = UINib(nibName: ProfileFirstCell.className, bundle: nil)
        table.register(first, forCellReuseIdentifier: ProfileFirstCell.className)

        let second = UINib(nibName: ProfileSecondCell.className, bundle: nil)
        table.register(second, forCellReuseIdentifier: ProfileSecondCell.className)

        let third = UINib(nibName: ProfileThirdCell.className, bundle: nil)
        table.register(third, forCellReuseIdentifier: ProfileThirdCell.className)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: topAnchor, constant: -50).isActive = true
        table.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        table.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -50).isActive = true
        table.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    private func makeButton(button: CustomButton, table: UITableView) {
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
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(greaterThanOrEqualTo: table.bottomAnchor, constant: 15).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true    }
}

// MARK: - Table View DataSource

extension ProfileViewImp: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileFirstCell.className, for: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSecondCell.className, for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileThirdCell.className, for: indexPath)
            return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
         return 3
     }
}

// MARK: - Table View Delegate

extension ProfileViewImp: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath.section)")
    }
}
