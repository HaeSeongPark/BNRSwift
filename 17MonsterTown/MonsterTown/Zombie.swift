//
//  Zombie.swift
//  MonsterTown
//
//  Created by Matthew D. Mathias on 8/28/14.
//  Copyright (c) 2014 BigNerdRanch. All rights reserved.
//

class Zombie: Monster {
    override class var spookyNoise: String {
        return "Brains..."
    }
    
    var walksWithLimp:Bool
    private(set) var isFallingApart:Bool
    
    init?(limp: Bool, fallingApart:Bool, town:Town?, monsterName:String) {
        walksWithLimp = limp
        isFallingApart = fallingApart
        super.init(town: town, monsterName: monsterName)
    }

    
    convenience init?(limp:Bool, fallingApart:Bool) {
        self.init(limp:limp, fallingApart: fallingApart, town:nil, monsterName:"Fred")
        if walksWithLimp {
            print("This zombie has a bad knee.")
        }
    }
    
// Silver Challenge : add convenience keyword and call designated initializer
    convenience required init?(town: Town?, monsterName: String) {
//        walksWithLimp = false
//        isFallingApart = false
//        super.init(town: town, monsterName: monsterName)
        self.init(limp:false, fallingApart:false, town:town, monsterName:monsterName)
    }
    
    final override func terrorizeTown() {
        if !isFallingApart {
            town?.changePopulation(by: -10)
        }
        super.terrorizeTown()
    }
    
    deinit {
        print("Zombie named \(name) is no longer with us")
    }
}
