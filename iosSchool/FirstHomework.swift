//
//  FirstHomework.swift
//  iosSchool
//
//  Created by student2 on 14.03.2023.
//

import Foundation

protocol Creature {
    var attack: Int { get }
    var health: Int { get set }
    var damage: [Int] { get }

    func attackModifier(defensiveProtection: Int) -> Int
    mutating func gotHit(damagePower: Int)
    func isAlive() -> Bool
    func attacks(gamer: Gamer, monster: inout Monster, attackModifier: Int)
    func getRandomValue(startOfRange: Int, endOfRange: Int) -> Int
}

extension Creature {
    func attackModifier(defensiveProtection: Int) -> Int {
        attack - defensiveProtection + 1
    }

    func getRandomValue(startOfRange: Int, endOfRange: Int) -> Int {
        Int.random(in: startOfRange...endOfRange)
    }
}

func isDataValid(attack: Int, protection: Int, health: Int, damage: [Int]) -> Bool {
    return  attack > 0 && attack < 21 && protection >= 0 && protection < 21 &&
            health > 0 && damage.count == 2 && damage[0] > 0 && damage[1] > 0
}

struct Monster: Creature {
    var attack: Int
    var health: Int
    var damage: [Int]
    var protection: Int?

    mutating func gotHit(damagePower: Int) {
        health -= damagePower
    }

    func isAlive() -> Bool {
        health > 0
    }

    func attacks(gamer: Gamer, monster: inout Monster, attackModifier: Int) {
        let cubes = Cubes(cubes: [attackModifier])
        cubes.fillCubes()
        if cubes.isAttackSuccessful() {
            gamer.gotHit(damagePower: getRandomValue(
                startOfRange: monster.damage[0],
                endOfRange: monster.damage[1]))
        }
    }

    init?(attack: Int, protection: Int?, health: Int, damage: [Int]) {
        if isDataValid(attack: attack, protection: protection ?? 0, health: health, damage: damage) {
            self.attack = attack
            self.protection = protection
            self.health = health
            self.damage = damage
        } else {
            return nil
        }
    }
}

class Gamer: Creature {
    var attack: Int
    var health: Int
    var damage: [Int]
    var protection: Int
    var startHealth: Int
    let level: Level
    var attemps = 0

    enum Level: Double {
        case low = 0.1
        case middle = 0.25
        case high = 0.5
    }

    func gotHit(damagePower: Int) {
        health -= damagePower
    }

    func isAlive() -> Bool {
        health > 0
    }

    func attacks(gamer: Gamer, monster: inout Monster, attackModifier: Int) {
        let cubes = Cubes(cubes: [attackModifier])
            cubes.fillCubes()
        if cubes.isAttackSuccessful() {
            monster.gotHit(damagePower: getRandomValue(
                startOfRange: gamer.damage[0],
                endOfRange: gamer.damage[1]))
        }
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
        health += recovery(percent: level.rawValue)
        attemps += 1
    }

    func recovery(percent: Double) -> Int {
        Int(Double(startHealth) * percent)
    }
}

class Cubes {
    var cubes: [Int]

    init(cubes: [Int]) {
        self.cubes = cubes
    }

    func getRandomValue(startOfRange: Int, endOfRange: Int) -> Int {
        Int.random(in: startOfRange...endOfRange)
    }

    func fillCubes() {
        for _ in 0...self.cubes.count {
            self.cubes.append(getRandomValue(startOfRange: 1, endOfRange: 6))
        }
    }

    func isAttackSuccessful() -> Bool {
        cubes.contains(5) || cubes.contains(6)
    }
}

func printInfo(gamer: Creature, monster: Creature) {
    print("Gamer health: \(gamer.health), \nMonster health: \(monster.health)")
}

func printResult(gamer: Creature) {
    if gamer.isAlive() {
        print("Gamer winner!")
    } else {
        print("Monster winner!")
    }
}
