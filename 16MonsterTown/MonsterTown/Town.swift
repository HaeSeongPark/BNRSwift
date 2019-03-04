//
//  Town.swift
//  MonsterTown
//
//  Created by Matthew D. Mathias on 8/22/14.
//  Copyright (c) 2014 BigNerdRanch. All rights reserved.
//

struct Town {
   static let region = "South"
    
    var mayor = Mayor()
    
    var population = 5422 {
        // Bronze Challenge
        willSet(newPopulation) {
            if ( population < newPopulation ) {
                print("warning! population has lowered")
                
                //Silver Challenge
                mayor.listen(to: .decrease)
            }
        }
        /////////////////
        didSet(oldPoppulation) {
            print("The population has changed to \(population) from \(oldPoppulation)")
        }
    }
    
    var numberOfStoplights = 4
    
    enum Size {
        case Small
        case Medium
        case Large
    }
    
    var townSize: Size {
        get {
            switch self.population {
            case 0...10000:
                return .Small
            case 10001...100000:
                return .Medium
            default:
                return .Large
            }
        }
    }
    
    func printDescription() {
        print("Population: \(population); number of stop lights: \(numberOfStoplights)")
    }
    
    mutating func changePopulation(by amount: Int) {
        population += amount
        
        if ( amount < 0 ) {
            mayor.listenZombieAttact()
        }
    }
}
