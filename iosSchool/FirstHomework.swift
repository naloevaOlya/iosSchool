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

enum HealingPercentage: Double {
    case ten = 0.1
    case twentyFive = 0.25
    case fifty = 0.5
}

struct Monster {
    var attack: Int
    var protection: Int?
    var health: Int
    var damage: [Int]

    // func isDataValid(attack: Int, protection: Int?, health: Int, damage: [Int] -> Bool {

    //}
}

class Gamer {
    var attack: Int
    var protection: Int
    var health: Int
    var startHealth: Int
    var damage: [Int]
    var level: Level
    var attemps = 0

    func isDataValid(_attack: Int, _protection: Int, _health: Int, _damage: [Int])throws {
        guard _attack > 0 && _attack < 21 && _protection > 0 && _protection < 21 && _health > 0 && _damage.count == 2 && _damage[0] > 0 && _damage[1] > 0 else {
            throw GameErrors.invalidData
        }
    }
    
    init(attack: Int, protection: Int, health: Int, damage: [Int], level: Level) throws {
        self.attack = attack
        self.protection = protection
        self.health = health
        self.startHealth = self.health
        self.damage = damage
        self.level = level

        try self.isDataValid(_attack: attack, _protection: protection, _health: health, _damage: damage)
    } // controversial

    enum Level: Double {
        case low = 0.0
        case middle = 0.5
        case high = 1.0
    }

    func recovery(percent: Double) -> Int { // mb another access level
        return Int(Double(self.startHealth) * percent)
    }

    func hill() {
        if self.attemps < 3 {
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
    }

    func attackModifier(defensive: Int?) throws -> Int {
        guard let defensive else {
            print("Monster's protection contains nil")
            throw GameErrors.protectionNil
        }
        return self.attack - defensive + 1
    }
}

class Cubes {
    var cubes: [Int]

    init(cubes: [Int]) {
        self.cubes = cubes
    }
}
