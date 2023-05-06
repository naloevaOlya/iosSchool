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
    private let apiClient: ApiClient
    private let updateQueue = DispatchQueue(label: "ImageServiceQueue")

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

    func getImage(url: String, completion: @escaping (UIImage?) -> Void) {
        guard imageDict[url] == nil else {
            completion(imageDict[url])
            return
        }
        if imageDict.count > 50 {
            imageDict.removeAll()
        }
        DispatchQueue.global().async {
            self.apiClient.requestImageData(url: url) { [weak self] content in
                guard let self else {
                return
                }
                self.updateQueue.async {
                    if let imgData = content {
                        self.imageDict[url] = UIImage(data: imgData)
                    }
                    completion(self.imageDict[url])
                }
            }
        }
    }
}
