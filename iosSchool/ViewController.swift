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
        guard var gamer = Gamer(attack: 17, protection: 6, health: 25, damage: [1, 6], level: .middle) else {
            print("Incorrect data for gamer")
            return
        }
        guard var monster = Monster(attack: 18, protection: 15, health: 40, damage: [1, 6]) else {
            print("Incorrect data for monster")
            return
        }
        while gamer.isAlive() && monster.isAlive() {
            printInfo(gamer: gamer, monster: monster)
            gamer.attacks(gamer: gamer, monster: &monster)
            monster.attacks(gamer: gamer, monster: &monster)
            if gamer.health < 10 && gamer.attemps < 3 {
                gamer.healing()
                print("Gamer was healled")
            }
        }
        printResult(gamer: gamer)
    }
}
