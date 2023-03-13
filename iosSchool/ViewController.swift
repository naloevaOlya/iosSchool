//
//  ViewController.swift
//  iosSchool
//
//  Created by student2 on 13.03.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var newGen = ColorGenerator(alpha: 1)
        newGen.alpha = 0.5
        var color = Color(red: 1, green: 1, blue: 1, alpha: .bright)
        color.descriotion()
        // Do any additional setup after loading the view.
    }
}

