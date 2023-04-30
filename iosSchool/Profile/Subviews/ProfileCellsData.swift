//
//  ProfileCellsData.swift
//  iosSchool
//
//  Created by student2 on 25.04.2023.
//

import UIKit

struct ProfileCellsData {
    var backPhoto: UIImage
    var circlePhoto: UIImage
    var userName: String
    var date: String

    init(backPhoto: UIImage?, circlePhoto: UIImage?, userName: String?, date: String?) {
        if let backPhoto, let circlePhoto {
            self.backPhoto = backPhoto
            self.circlePhoto = ProfileCellsData.logoImageSetting(photo: circlePhoto)
        } else {
            self.backPhoto = UIImage(named: "profle-background") ?? UIImage()
            self.circlePhoto = UIImage(named: "userButton") ?? UIImage()
        }
        self.userName = userName ?? "Login"
        self.date = date ?? ".. .. ...."
    }

    static private func logoImageSetting(photo: UIImage) -> UIImage {
        let imgSize = CGSize(width: 110, height: 110)
        let imgWithBorder = UIGraphicsImageRenderer(size: imgSize).image { _ in
            let imgFrame = CGRect(origin: .zero, size: imgSize)
            let circle = UIBezierPath(ovalIn: imgFrame)
            circle.addClip()
            photo.draw(in: imgFrame)
            circle.lineWidth = 5
            UIColor(named: "cellColor")?.withAlphaComponent(0.7).setStroke()
            circle.stroke()
        }
        return imgWithBorder
    }
}
