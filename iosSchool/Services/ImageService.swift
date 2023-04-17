//
//  ImageService.swift
//  iosSchool
//
//  Created by student2 on 17.04.2023.
//

import UIKit

protocol ImageService {
    func getImage(url: String, completion: @escaping (UIImage?) -> Void)
}

class ImageServiceImp: ImageService {
    private var imageDict: [String: UIImage] = [:]

    private let apiClieent: ApiClient
    private let updateQueue = DispatchQueue(label: "ImageServiceQueuee")

    init(apiClieent: ApiClient) {
        self.apiClieent = apiClieent
    }

    func getImage(url: String, completion: @escaping (UIImage?) -> Void) {
    }

}
