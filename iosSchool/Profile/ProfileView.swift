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

    func makeView() {
        tableView.backgroundColor = UIColor(named: "Lillac80")?.withAlphaComponent(1) ?? .white
        tableView.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0)
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        let first = UINib(nibName: ProfileFirstCell.className, bundle: nil)
        tableView.register(first, forCellReuseIdentifier: ProfileFirstCell.className)

        let second = UINib(nibName: ProfileSecondCell.className, bundle: nil)
        tableView.register(second, forCellReuseIdentifier: ProfileSecondCell.className)

        let third = UINib(nibName: ProfileThirdCell.className, bundle: nil)
        tableView.register(third, forCellReuseIdentifier: ProfileThirdCell.className)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

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

extension ProfileViewImp: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath.section)")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 356
        } else if indexPath.section == 1 {
            return 53
        } else {
            return 178
        }
    }
}
