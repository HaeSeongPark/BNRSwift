//
//  Monster.swift
//  MonsterTown
//
//  Created by Matthew D. Mathias on 8/28/14.
//  Copyright (c) 2014 BigNerdRanch. All rights reserved.
//

class Monster {
    class var spookyNoise: String {
        return "Grrr"
    }
    static let isTerrifying = true
    var town: Town?
    var name:String
    
    var victimPool: Int {
        get {
            return town?.population ?? 0
        }
        set(newVictimPool) {
            town?.population = newVictimPool
        }
    }
    
    required init?(town: Town?, monsterName:String) {
        guard !monsterName.isEmpty else {
            return nil
        }
    
        self.town = town
        name = monsterName
    }
    
    func terrorizeTown() {
        if let _ = town {
            print("\(name) is terrorizing a town!")
        } else {
            print("\(name) hasn't found a town to terrorize yet...")
        }
    }
}
