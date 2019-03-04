//
//  Mayor.swift
//  MonsterTown
//
//  Created by rhino Q on 04/03/2019.
//  Copyright © 2019 BigNerdRanch. All rights reserved.
//

import Foundation
// Silver Challenge
struct Mayor {
    
    private var anxietyLevel = 0
    
    enum PopulationChanged {
        case decrease
        case increase
    }
    
    func listen(to populationChagnd: PopulationChanged) {
        switch populationChagnd {
        case .decrease:
            print("I'm deeply saddened to hear about this lastes tragedy. I promise that my office is looking into the nature of this rash of violence.")
        case .increase:
            break // noting to do
        }
    }
    
    // Gold Challenge
    
    mutating func listenZombieAttact() {
        anxietyLevel += 10
    }
}
