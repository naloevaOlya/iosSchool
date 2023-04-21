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
        backgroundColor = UIColor(named: "Lillac80") ?? .white
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        tableView.topAnchor.constraint(equalTo: topAnchor, constant: -50).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -50).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        exitButton.backgroundColor = UIColor(named: "VelvetBlue") ?? .white
        exitButton.highlightColor = .white
        exitButton.layer.cornerRadius = 10
        exitButton.layer.borderColor = UIColor(named: "DarkBlue")?.withAlphaComponent(0.22).cgColor
        exitButton.layer.borderWidth = 1
        exitButton.layer.shadowOpacity = 0.25
        exitButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        exitButton.layer.shadowRadius = 4
        exitButton.setTitle("Выйти", for: .normal)
        exitButton.setTitleColor(.white, for: .normal)
        exitButton.setTitleColor(.black, for: .highlighted)
        addSubview(exitButton)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.topAnchor.constraint(greaterThanOrEqualTo: tableView.bottomAnchor, constant: 15).isActive = true
        exitButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        exitButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        exitButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
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
