//
//  Accountant.swift
//  CyclicalAssets
//
//  Created by rhino Q on 24/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

import Foundation

class Accountant{
    typealias NetWorthChaned = (Double) -> ()
    
    var netWorthChangdHandler: NetWorthChaned? = nil
    var netWorth: Double = 0.0 {
        didSet {
            netWorthChangdHandler?(netWorth)
        }
    }
    
    func gainedNewAsset(asset: Asset, completion: () -> Void ) {
        netWorth += asset.value
        completion()
    }
    
    func removeNewAsset(asset: Asset, completion: () -> Void ) {
        netWorth -= asset.value
        completion()
    }
}
