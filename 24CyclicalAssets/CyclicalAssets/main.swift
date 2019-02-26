//
//  main.swift
//  CyclicalAssets
//
//  Created by rhino Q on 24/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

import Foundation

var bob:Person? = Person(name: "Bob")
print("created \(bob.debugDescription)");

var bigBob = Person(name: "bigBob")

var laptop:Asset? = Asset(name: "Shiny Laptopp", value: 1500.0)
var hat:Asset? = Asset(name: "Cowboy Hat", value: 175.0)
var backpack:Asset? = Asset(name: "Blue backpack", value: 45.0)

bob?.useNetWorthChangedHandler { netWorth in
    print("Bob's net worth in now \(netWorth)")
}

bob?.takeOwnershipOfAsset(asset: laptop!)
bob?.takeOwnershipOfAsset(asset: hat!)

bigBob.takeOwnershipOfAsset(asset: laptop!)

print("While Bob is alive, hat's owner is \(hat!.owner.debugDescription)")
bob?.removeOwnershipOfAsset(asset: hat!)
print("While Bob is alive, hat's owner is \(hat!.owner.debugDescription)")


bob = nil
print("the bob variable is now \(bob.debugDescription)")
print("After Bob is deallocated, hat's owner is \(hat!.owner.debugDescription)")
hat = nil
backpack = nil


