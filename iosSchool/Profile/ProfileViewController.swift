//
//  PrivateViewController.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import UIKit
import Photos
import PhotosUI

class ProfileViewController<View: ProfileViewImp>: BaseViewController<View> {

    private var storageManager: StorageManager

    var exitButtonDidTap: (() -> Void)?

    init(storageManager: StorageManager, exitButtonDidTap: (() -> Void)?) {
        self.storageManager = storageManager
        self.exitButtonDidTap = exitButtonDidTap
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.makeView()
        rootView.delegate = self
        rootView.update(data: setData())
        rootView.exitButtonAction = exitButtonDidTap
    }

    private func setData() -> ProfileCellsData {
        return ProfileCellsData(
            backPhoto: storageManager.getUserPhoto(),
            circlePhoto: storageManager.getUserPhoto(),
            userName: storageManager.getUserName().isEmpty ? nil : storageManager.getUserName(),
            date: storageManager.getAppLaunchDate().isEmpty ? nil : storageManager.getAppLaunchDate()
        )
    }
}

extension ProfileViewController: ProfileViewDelegate, PHPickerViewControllerDelegate {
    func setPhotoFromAlbum() {
        openPHPicker()
    }

    func deletePhoto() {
        storageManager.removeUserPhoto()
        DispatchQueue.main.async {
            self.rootView.update(data: self.setData())
        }
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self.storageManager.saveUserPhoto(photo: image)
                    self.rootView.update(data: self.setData())
                }
            }
        }
    }

    func openPHPicker() {
        var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
        phPickerConfig.selectionLimit = 1
        phPickerConfig.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
        phPickerVC.delegate = self
        present(phPickerVC, animated: true)
    }
}
