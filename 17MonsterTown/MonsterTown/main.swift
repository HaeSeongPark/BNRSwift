//
//  main.swift
//  MonsterTown
//
//  Created by Matthew D. Mathias on 8/22/14.
//  Copyright (c) 2014 BigNerdRanch. All rights reserved.
//

var myTown = Town(population: 10000, stoplights: 6)
myTown?.printDescription()

let myTownSize = myTown?.townSize
print(myTownSize)

myTown?.changePopulation(by: 1_000_000)
print("Size: \(String(describing: myTown?.townSize)); population: \(String(describing: myTown?.population))")

var fredTheZombie:Zombie? = Zombie(limp: false, fallingApart: false, town: myTown, monsterName: "Fred")
fredTheZombie?.town = myTown
fredTheZombie?.terrorizeTown()
fredTheZombie?.town?.printDescription()

print("Victim pool: \(String(describing: fredTheZombie?.victimPool))")
fredTheZombie?.victimPool = 500
print("Victim pool: \(String(describing: fredTheZombie?.victimPool))")

print(Zombie.spookyNoise)
if Zombie.isTerrifying {
    print("Run away!")
}

fredTheZombie = nil
var convenientZombie = Zombie(limp: true, fallingApart: false)
var testSiverChallenge = Zombie(town: myTown, monsterName: "sdf")
var testGoldChallenge = Zombie(town: myTown, monsterName: "")
print(testGoldChallenge) // nil, passed
