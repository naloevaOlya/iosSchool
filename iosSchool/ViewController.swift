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
        do {
            var gamer = try Gamer(attack: 17, protection: 6, health: 25,
                                   damage: [1, 6], level: Gamer.Level.middle)
            var monster = try Monster(attack: 18, protection: 15,
                                       health: 40, damage: [1, 6])

            while isCreatureLive(health: gamer.health) &&
                    isCreatureLive(health: monster.health) {
                printInfo(gamer: gamer, monster: monster)
                try gamerAttacks(gamer: gamer, monster: &monster)
                monsterAttacks(gamer: gamer, monster: monster)
                if gamer.health < 10 && gamer.attemps < 3 {
                    gamer.healing()
                    print("Gamer was healled")
                }
            }
            printResult(gamer: gamer)
        } catch GameErrors.invalidData {
            print("Incorrect data for creature")
        } catch GameErrors.protectionNil {
            print("Error: there is no value in the protection parameter of the monster")
        } catch {
            print("Unexpected error")
        }
    }
}
