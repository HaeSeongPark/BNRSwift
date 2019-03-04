//
//  main.swift
//  MonsterTown
//
//  Created by Matthew D. Mathias on 8/22/14.
//  Copyright (c) 2014 BigNerdRanch. All rights reserved.
//

var myTown = Town()
let ts = myTown.townSize
print(ts)
myTown.changePopulation(by: 1_000_000)
print("Size : \(myTown.townSize); popultaion: \(myTown.population)")
let fredTheZombie = Zombie()
fredTheZombie.town = myTown
fredTheZombie.terrorizeTown()

//Gold Ghallenge
//print(myTown.mayor.anxietyLevel) anxietyLevel is not accessbile in main.swift file Becuase anxietyLevel is private property

fredTheZombie.town?.printDescription()

print("Victim pool: \(fredTheZombie.victimPool)")
fredTheZombie.victimPool = 500
print("Victim pool: \(fredTheZombie.victimPool)")
print(Zombie.spookyNoise)
if Zombie.isTerrifying {
    print("Run away!")
}
