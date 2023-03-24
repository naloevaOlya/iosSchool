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
        guard var gamer: CreatureProtocol = Gamer(
            attack: 17,
            protection: 6,
            health: 25,
            damage: [1, 6],
            level: .middle) else {
            return
        }
        guard var monster: CreatureProtocol = Monster(
            attack: 18,
            protection: 15,
            health: 40,
            damage: [1, 6]) else {
            return
        }
        while gamer.isAlive() && monster.isAlive() {
            printInfo(gamer: gamer, monster: monster)
          //  gamer.attackModifier(gamer: gamer, monster: monster)
            break
                // monster.attacks(gamer: gameras? , monster: &monster)
                //  if gamer.health < 10 && gamer.attemps < 3 {
                //    gamer.healing()
                //  print("Gamer was healled")
            }
         printResult(gamer: gamer)
    }
}
