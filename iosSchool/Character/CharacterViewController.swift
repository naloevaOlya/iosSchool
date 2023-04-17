//
//  CharacterViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit

class CharacterViewController: UIViewController {
    private var characters: [Character] = []
    private let dataProvider: CharacterDataProvider
    private let charactersUrlsList: [String]
    private let updateQueue = DispatchQueue(label: "CharacterRequestQueuee")
    private let imageService: ImageService

    init(dataProvider: CharacterDataProvider, viewModel: LocationCellData, imageSrvice: ImageService) {
        self.dataProvider = dataProvider
        self.charactersUrlsList = viewModel.residents
        self.imageService = imageSrvice
        super.init(nibName: nil, bundle: nil)
        self.title = "residents of liocattion \(viewModel.name)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented ")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        charactersUrlsList.forEach { url in
            requestCharacter(url: url) { [weak self] character in
                self?.imageService.getImage(url: character.image) { image in
                    print(image?.size ?? 0)
                }
//                print(character.name)
            }
        }
    }

    private func requestCharacter(url: String, completion: @escaping (Character) -> Void) {
        if let character = characters.first(where: { $0.url == url }) {
            completion(character)
            return
        }
        DispatchQueue.global().async {
            self.dataProvider.getCharacter(url: url) { [weak self] result in
                switch result {
                case let .success(character):
                    self?.updateQueue.async {
                        self?.characters.append(character)
                        completion(character)
                    }
                case .failure:
                    print("character fail")
                }
            }
        }
    }
}
