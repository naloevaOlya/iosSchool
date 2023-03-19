//
//  FirstHomework.swift
//  iosSchool
//
//  Created by student2 on 14.03.2023.
//

import Foundation

func isDataValid(attack: Int, protection: Int, health: Int, damage: [Int]) -> Bool {
    return  attack > 0 && attack < 21 && protection >= 0 && protection < 21 &&
            health > 0 && damage.count == 2 && damage[0] > 0 && damage[1] > 0
}

func isCreatureLive(health: Int) -> Bool {
    return health > 0
}

func getRandomValue(startOfRange: Int, endOfRange: Int) -> Int {
    return Int.random(in: startOfRange...endOfRange)
}

struct Monster {
    var attack: Int
    var protection: Int?
    var health: Int
    var damage: [Int]

    init?(attack: Int, protection: Int?, health: Int, damage: [Int]) {
        let protection = protection ?? 0
        if isDataValid(attack: attack, protection: protection, health: health, damage: damage) {
            self.attack = attack
            self.protection = protection
            self.health = health
            self.damage = damage
        } else {
            return nil
        }
    }

    func attackModifier(defensive: Int, attack: Int) -> Int {
        return self.attack - defensive + 1
    }

    mutating func gotHit(damagePower: Int) {
        self.health -= damagePower
    }
}

class Gamer {
    var attack: Int
    var protection: Int
    var health: Int
    var startHealth: Int
    var damage: [Int]
    let level: Level
    var attemps = 0

    enum Level: Double {
        case low = 0.1
        case middle = 0.25
        case high = 0.5
    }

    init?(attack: Int, protection: Int, health: Int, damage: [Int], level: Level) {
        if !isDataValid(attack: attack, protection: protection, health: health, damage: damage) {
            return nil
        }
        self.attack = attack
        self.protection = protection
        self.health = health
        self.startHealth = self.health
        self.damage = damage
        self.level = level
    }

    func healing() {
        self.health += self.recovery(percent: self.level.rawValue)
        self.attemps += 1
    }

    func attackModifier(defensive: Int?, attack: Int) -> Int {
        let defensive = defensive ?? 0
        return self.attack - defensive + 1
    }

    func recovery(percent: Double) -> Int {
        return Int(Double(self.startHealth) * percent)
    }

    func gotHit(damagePower: Int) {
        self.health -= damagePower
    }
}

class Cubes {
    var cubes: [Int]

    init(cubes: [Int]) {
        self.cubes = cubes
    }

    func fillCubes() {
        for _ in 0...self.cubes.count {
            self.cubes.append(getRandomValue(startOfRange: 1, endOfRange: 6))
        }
    }

    func isAttackSuccessful() -> Bool {
        return  self.cubes.contains(5) || self.cubes.contains(6)
    }
}

    func monsterAttacks(gamer: Gamer, monster: Monster) {
        let attackModifier = monster.attackModifier(defensive: gamer.protection, attack: monster.attack)
        let cubes = Cubes(cubes: [attackModifier])
        cubes.fillCubes()
        if cubes.isAttackSuccessful() {
            gamer.gotHit(damagePower: getRandomValue(startOfRange: monster.damage[0], endOfRange: monster.damage[1]))
        }
    }

    func gamerAttacks(gamer: Gamer, monster: inout Monster) {
        let attackModifier = gamer.attackModifier(defensive: monster.protection, attack: gamer.attack)
        let cubes = Cubes(cubes: [attackModifier])
        cubes.fillCubes()
        if cubes.isAttackSuccessful() {
            monster.gotHit(damagePower: getRandomValue(startOfRange: gamer.damage[0], endOfRange: gamer.damage[1]))
        }
    }

    func printInfo(gamer: Gamer, monster: Monster) {
        print("Gamer health: \(gamer.health), attemps: \(gamer.attemps) \nMonster health: \(monster.health)")
    }

    func printResult(gamer: Gamer) {
        if  isCreatureLive(health: gamer.health) {
            print("Gamer winner!")
        } else {
            print("Monster winner!")
        }
    }
