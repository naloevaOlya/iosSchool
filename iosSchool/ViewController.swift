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

        var gamer, monster: Creature
        guard var gamer = Gamer(attack: 17, protection: 6, health: 25, damage: [1, 6], level: .middle) else {
            return
        }
        guard var monster = Monster(attack: 18, protection: 15, health: 40, damage: [1, 6]) else {
            return
        }
        let gamerModifier = gamer.attackModifier(defensiveProtection: (monster.protection ?? 0))
        let monsterModifier = monster.attackModifier(defensiveProtection: gamer.protection)

        while gamer.isAlive() && monster.isAlive() {
            printInfo(gamer: gamer, monster: monster)
            gamer.attacks(gamer: gamer, monster: &monster, attackModifier: gamerModifier)
            monster.attacks(gamer: gamer, monster: &monster, attackModifier: monsterModifier)
            if gamer.health < 10 && gamer.attemps < 3 {
                gamer.healing()
                print("Gamer was healled to \(gamer.health)")
            }
       }
        printResult(gamer: gamer)
    }
}
