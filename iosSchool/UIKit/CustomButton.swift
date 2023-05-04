//
//  CustomButton.swift
//  iosSchool
//
//  Created by student2 on 31.03.2023.
//

import UIKit

class CustomButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            tintColor = isHighlighted ? .black : .white
            backgroundColor = isHighlighted ? highlightColor : normalColor
        }
    }

    @IBInspectable
    var highlightColor: UIColor = .white
    @IBInspectable
    var  normalColor: UIColor = .white
}
