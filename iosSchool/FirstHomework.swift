//
//  FirstHomework.swift
//  iosSchool
//
//  Created by student2 on 14.03.2023.
//

import Foundation

enum GameErrors: Error {
    case protectionNil
    case invalidData
}

func checkData(attack: Int, protection: Int, health: Int, damage: [Int])throws {
    guard attack > 0 && attack < 21 && protection > 0 && protection < 21 &&
            health > 0 && damage.count == 2 && damage[0] > 0 && damage[1] > 0 else {
        throw GameErrors.invalidData
    }
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

    init(attack: Int, protection: Int?, health: Int, damage: [Int]) throws {
        guard let protection else {
            throw GameErrors.invalidData
        }
        try checkData(attack: attack, protection: protection, health: health, damage: damage)
        self.attack = attack
        self.protection = protection
        self.health = health
        self.damage = damage
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
        case low = 0.0
        case middle = 0.5
        case high = 1.0
    }

    enum HealingPercentage: Double {
        case ten = 0.1
        case twentyFive = 0.25
        case fifty = 0.5
    }

    init(attack: Int, protection: Int, health: Int, damage: [Int], level: Level) throws {
        try checkData(attack: attack, protection: protection, health: health, damage: damage)
        self.attack = attack
        self.protection = protection
        self.health = health
        self.startHealth = self.health
        self.damage = damage
        self.level = level
    }

    func healing() {
            switch self.level {
            case .low:
                self.health += self.recovery(percent: HealingPercentage.ten.rawValue)
            case .middle:
                self.health += self.recovery(percent: HealingPercentage.twentyFive.rawValue)
            case .high:
                self.health += self.recovery(percent: HealingPercentage.fifty.rawValue)
            }
            self.attemps += 1
    }

    func attackModifier(defensive: Int?, attack: Int) throws -> Int {
        guard let defensive else {
            throw GameErrors.protectionNil
        }
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

    func fillCubes(modifier: Int) {
        for _ in 0...modifier {
            self.cubes.append(getRandomValue(startOfRange: 1, endOfRange: 6))
        }
    }

    func isAttackSuccessful() -> Bool {
        if self.cubes.contains(5) || self.cubes.contains(6) {
            return true
        } else {
            return false
        }
    }
}

func initCube(gamer: Gamer, monster: Monster, modifier: Int) -> Cubes {
    let cubes = Cubes(cubes: [monster.attackModifier(defensive: gamer.protection, attack: monster.attack)])
    cubes.fillCubes(modifier: modifier)
    return cubes
}

func monsterAttacks(gamer: Gamer, monster: Monster) {
    let attackModifier = monster.attackModifier(defensive: gamer.protection, attack: monster.attack)
    let cubes = initCube(gamer: gamer, monster: monster, modifier: attackModifier)
    if cubes.isAttackSuccessful() {
        gamer.gotHit(damagePower: getRandomValue(startOfRange: monster.damage[0], endOfRange: monster.damage[1]))
    }
}

func gamerAttacks(gamer: Gamer, monster: inout Monster)throws {
    let attackModifier = try gamer.attackModifier(defensive: monster.protection, attack: gamer.attack)
    let cubes = initCube(gamer: gamer, monster: monster, modifier: attackModifier)
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
