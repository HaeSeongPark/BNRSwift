//
//  Town.swift
//  MonsterTown
//
//  Created by Matthew D. Mathias on 8/22/14.
//  Copyright (c) 2014 BigNerdRanch. All rights reserved.
//

struct Town {
    let region:String
    var population:Int{
        didSet(oldPopulation) {
            print("The population has changed to \(population) from \(oldPopulation).")
        }
    }
    
    init?(region:String, population:Int, stoplights:Int) {
        if population <= 0 { return nil }
        
        self.region = region
        self.population = population
        numberOfStoplights = stoplights
    }
    
    init?(population: Int, stoplights:Int) {
        self.init(region: "N/A", population: population, stoplights: stoplights)
    }
    
    var numberOfStoplights: Int
    
    enum Size {
        case small
        case medium
        case large
    }
    
    var townSize: Size {
        get {
            switch self.population {
            case 0...10_000:
                return Size.small
                
            case 10_001...100_000:
                return Size.medium
                
            default:
                return Size.large
            }
        }
    }
    
    func printDescription() {
        print("Population: \(population); number of stop lights: \(numberOfStoplights); region:\(region)")
    }
    
    mutating func changePopulation(by amount: Int) {
        population += amount
    }
}
