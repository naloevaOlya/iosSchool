//
//  LocationView.swift
//  iosSchool
//
//  Created by student2 on 14.04.2023.
//

import UIKit

protocol LocationView: UIView {
    var selectLocation: ((LocationCellData) -> Void)? { get set }
    func makeView()
    func update(data: LocationViewData)
}

class LocationViewImp: UIView, LocationView {

    var selectLocation: ((LocationCellData) -> Void)?

    private var locationData: LocationViewData?

    private let imageView = UIImageView()
    private let tableView = UITableView()

    func makeView() {
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        tableView.dataSource = self
        tableView.delegate = self

        let nib = UINib(nibName: LocationCell.classNmae, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: LocationCell.classNmae)
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    func update(data: LocationViewData) {
        locationData = data
        DispatchQueue.main.async { [ weak self ] in
            self?.tableView.reloadData()
        }
    }
}

extension LocationViewImp: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let locationData,
           let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.classNmae) as? LocationCell {
            cell.viewModel = locationData.cellVM[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locationData?.cellVM.count ?? 0
    }
}

extension LocationViewImp: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let locationData, locationData.cellVM.count > indexPath.row  else {
            return
        }
        selectLocation?(locationData.cellVM[indexPath.row])
    }
}
