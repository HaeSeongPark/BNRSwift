//
//  Person.swift
//  CyclicalAssets
//
//  Created by rhino Q on 24/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

import Foundation

class Person: CustomStringConvertible {
    let name : String
    let accountant = Accountant()
    var assets = [Asset]()
    var description: String {
        return "Person(\(name))"
    }
    
    init(name:String) {
        self.name = name;
        
        accountant.netWorthChangdHandler = {
            [weak self] netWroth in
            self?.netWorthDidChange(to: netWroth)
            return
        }
    }
    
    deinit {
        print("\(self) is being deallocated")
    }
    
    func takeOwnershipOfAsset(asset:Asset){
        if asset.owner == nil {
            accountant.gainedNewAsset(asset: asset) {
                asset.owner = self
                assets.append(asset)
            }
        } else {
            print("asset is already owend by \(asset.owner!.name.debugDescription)")
        }
        
    }
    
    func removeOwnershipOfAsset(asset:Asset) {
//        if assets.firstIndex(where: {($0.name == asset.name && $0.value == asset.value)}) {
//            
//        }
        
        if let i = assets.firstIndex(of: asset) {
            accountant.removeNewAsset(asset: asset) {
                asset.owner = nil
                assets.remove(at: i)
            }
        }
    }
    
    func netWorthDidChange(to netWorth: Double) {
        print("sdfdsdff")
        print("The net worth of \(self) is now \(netWorth)")
    }
    
    func useNetWorthChangedHandler(handler: @escaping(Double)->Void) {
        accountant.netWorthChangdHandler = handler
    }
}
