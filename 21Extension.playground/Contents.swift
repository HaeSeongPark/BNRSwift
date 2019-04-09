//
//  21Extension.swift
//
//
//  Created by rhino Q on 09/04/2019.
//

import Foundation

typealias Velocity = Double

extension Velocity {
    var kph: Velocity { return self * 1.60934 }
    var mph: Velocity { return self }
}

protocol Vehicle {
    var topSpeed:Velocity { get }
    var numberOfDoors: Int { get }
    var hasFlatbed: Bool { get }
}

struct Car {
    let make: String
    let model: String
    let year: Int
    let color: String
    let nickNname: String
    var numberOfDoors:Int
    var gasLevel: Double {
        willSet {
            precondition(newValue <= 1.0 && newValue >= 0.0,
                         "New value must be between 0 and 1.")
        }
    }
}
// protocol conformance
extension Car: Vehicle {
    var topSpeed: Velocity { return 180 }
    var hasFlatbed: Bool { return false }
}
// adding an initialzer
extension Car {
    init(carMake: String, carModel:String, carYear:Int) {
        self.init(make: carMake, model: carModel, year: carYear, color: "Black", nickNname: "N/A", numberOfDoors: 4, gasLevel: 1.0)
    }
}

var car = Car(carMake: "Ford", carModel: "Fusion", carYear: 2013)

// adding nested types
extension Car {
    
    enum Kind:CustomStringConvertible {
        case coupe, sedan
        var description: String {
            switch self {
            case .coupe:
                return "Coupe"
            case .sedan:
                return "Sedan"
            }
        }
    }
    var kind:Kind {
        if numberOfDoors == 2 {
            return .coupe
        } else {
            return .sedan
        }
    }
}
car.kind.description

// adding functions
extension Car {
    mutating func emptyGas(amount: Double) {
        precondition(amount <= 1 && amount > 0, "Amount to remove must be between 0 and 1.")
        gasLevel -= amount
    }
    
    mutating func fillGas() {
        gasLevel = 1.0
    }
}
car.emptyGas(amount: 0.3)
car.gasLevel
car.fillGas()
car.gasLevel

// First Bronze Challenge
extension Int {
    var timeFive: Int {
        return self * 5
    }
}
5.timeFive
