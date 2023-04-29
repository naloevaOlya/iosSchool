//
//  CharacterCellData.swift
//  iosSchool
//
//  Created by student2 on 21.04.2023.
//

import UIKit

struct CharacterCellData {

    let url: String
    let isLoading: Bool
    let imageUrl: String?
    let image: UIImage!
    let name: String?
    let type: String?

    init(url: String) {
        self.url = url
        isLoading = true
        image = nil
        imageUrl = nil
        name = nil
        type = nil
    }

    init(character: Character, image: UIImage?, isLoading: Bool) {
        url = character.url
        self.isLoading = isLoading
        self.image = image
        imageUrl = character.image
        name = character.name
        type = " \(character.gender) \(character.species)"
    }
}
