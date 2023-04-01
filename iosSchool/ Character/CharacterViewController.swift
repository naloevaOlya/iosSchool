//
//  CharacterViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit

class CharacterViewController: UIViewController {
    private let dataProvider: CharacterDataProvider

    init(dataProvider: CharacterDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented ")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        dataProvider.getCharacter(url: "https://rickandmortyapi.com/api/character/38") { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.rawValue)
            }
         }
    }
}
