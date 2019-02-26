//
//  Asset.swift
//  CyclicalAssets
//
//  Created by rhino Q on 24/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

import Foundation

class Asset: CustomStringConvertible, Equatable {
    let name:String
    let value:Double
    weak var owner:Person?
    
    var description: String {
        if let actualOwner = owner {
            return "Asset(\(name), worth \(value), owned by \(actualOwner))"
        } else {
            return "Asset(\(name), worth \(value), not owned by anyone)"
        }
    }
    
    init(name:String, value:Double) {
        self.name = name
        self.value = value
    }
    
    deinit {
        print("\(self) is being deallocated")
    }
    
    static func == (lhs: Asset, rhs: Asset) -> Bool {
        return (lhs.name == rhs.name ) && (lhs.value == rhs.value)
    }
}
