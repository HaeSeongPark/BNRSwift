//: [Previous](@previous)

import Foundation

class Person: Equatable {
    
    var name:String
    weak var spouse: Person?
    
    init(name:String, spouse: Person?) {
        self.name = name
        self.spouse = spouse
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return ( lhs.name == rhs.name ) && ( lhs.spouse == rhs.spouse )
    }
    
    // more readable and maintainable than +++ custom operator
    func marry(_ spouse:Person){
        self.spouse = spouse
        spouse.spouse = self
    }
}

let matt = Person(name: "Matt", spouse: nil)
let drew = Person(name: "Drew", spouse: nil)


//precedencegroup DefaultPrecedence {
//    higherThan: TernaryPrecedence
//}

infix operator +++

func +++(lhs:Person, rhs: Person) {
    lhs.spouse = rhs
    rhs.spouse = lhs
}

matt +++ drew
matt.spouse?.name
drew.spouse?.name


//: [Next](@next)
