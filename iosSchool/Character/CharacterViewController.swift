//
//  CharacterViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit

class CharacterViewController<View: CharacterView>: BaseViewController<View> {
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
        view.backgroundColor = UIColor(named: "Lillac80")
        rootView.makeViews()
        let data = CharacterViewData(cells: charactersUrlsList.map { CharacterCellData(url: $0) })
        rootView.update(data: data)

        charactersUrlsList.forEach { url in
            requestCharacter(url: url) { [weak self] character in
                guard let self else {
                    return
                }
                DispatchQueue.main.async {
                    self.rootView.updateCharacter(url: character.url, with: CharacterCellData(
                        character: character,
                        image: nil,
                        isLoading: true
                    ))
                }

                self.imageService.getImage(url: character.url) { [weak self] image in
                    guard let self else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.rootView.updateCharacter(url: character.url, with: CharacterCellData(
                            character: character,
                            image: image,
                            isLoading: false
                        ))
                    }
                }
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
