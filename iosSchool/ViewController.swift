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
        let level: Gamer.Level = .middle

        guard var gamer: Creature = Gamer(attack: 17, protection: 6, health: 25, damage: [1, 6], level: level) else {
            return
        }
        guard var monster: Creature  = Monster(attack: 18, protection: 15, health: 40, damage: [1, 6]) else {
            return
        }
        let gamerModifier = gamer.attackModifier(defensiveProtection: monster.protection)
        let monsterModifier = monster.attackModifier(defensiveProtection: gamer.protection)
        var gamerAttemps = 0
        let startHealth = gamer.health

        while gamer.isAlive() && monster.isAlive() {
            printInfo(gamer: gamer, monster: monster)
            gamer.attacks(gamer: &gamer, monster: &monster, attackModifier: gamerModifier)
            monster.attacks(gamer: &gamer, monster: &monster, attackModifier: monsterModifier)
            if gamer.health < 10 && gamerAttemps < 3 {
                gamer.health += Int(Double(startHealth) * level.rawValue)
                gamerAttemps += 1
                print("Gamer was healled to \(gamer.health)")
            }
       }
        printResult(gamer: gamer)
    }
}
