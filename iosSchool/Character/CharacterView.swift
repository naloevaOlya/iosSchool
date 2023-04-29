//
//  CharacterView.swift
//  iosSchool
//
//  Created by student2 on 21.04.2023.
//

import UIKit

protocol CharacterView: UIView {
    func makeViews()
    func update(data: CharacterViewData)
    func updateCharacter(url: String, with data: CharacterCellData)
}

class CharacterViewImp: UIView, CharacterView {

    private var data: [CharacterCellData] = []
    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: layout())
    }()

    func makeViews() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.contentInset.top = 59
        collectionView.contentInset.bottom = 59
        let nib = UINib(nibName: CharacterCell.classNmae, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CharacterCell.classNmae)
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    func updateCharacter(url: String, with data: CharacterCellData) {
        guard let index = self.data.firstIndex(where: { $0.url == url }) else {
            return
        }
        self.data[index] = data
        guard let cell = collectionView.cellForItem(at: .init(row: index, section: 0)) as? CharacterCell else {
            return
        }
        cell.viewModel = data
    }

    func update(data: CharacterViewData) {
        self.data = data.cells
        collectionView.reloadData()
    }

    // MARK: - Private Methods

    private func layout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(sectionProvider: provider())
    }

    private func provider() -> UICollectionViewCompositionalLayoutSectionProvider {
        { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(167)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(167)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                repeatingSubitem: item,
                count: 2
            )
            group.contentInsets.leading = 20
            group.contentInsets.trailing = 20
            group.interItemSpacing = .fixed(16)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 30
            return section
        }
    }
}

// MARK: - DataSource Methods

extension CharacterViewImp: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCell.classNmae,
            for: indexPath
        ) as? CharacterCell else {
            return UICollectionViewCell()
        }
        guard data.count > indexPath.row else {
            return cell
        }
        cell.viewModel = data[indexPath.row]
        return cell
    }
}
