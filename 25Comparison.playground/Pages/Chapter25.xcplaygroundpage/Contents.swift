import Foundation

struct Point: Comparable { // don't need 'Equatable' if you conform Comparable. Because it inherits from Equatable
    
    let x:Int
    let y:Int
    

    
    //precedencegroup ComparisonPrecedence {
    //    higherThan: LogicalConjunctionPrecedence
    //}
    //
    //infix operator == : ComparisonPrecedence

    
//    static func ==(lhs:Point, rhs:Point) -> Bool {
//        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
//    }
//
//    static func < (lhs: Point, rhs: Point) -> Bool {
//        return (lhs.x < rhs.x) && (lhs.y < rhs.y)
//    }
    
    // Platinum Challenge
    func euclideanDistanceFromOrigin() -> Double {
        return sqrt( Double(x * x) + Double(y * y) )
    }
    
    static func ==(lhs:Point, rhs:Point) -> Bool {
        return lhs.euclideanDistanceFromOrigin() == rhs.euclideanDistanceFromOrigin()
    }
    
    static func < (lhs: Point, rhs: Point) -> Bool {
        return lhs.euclideanDistanceFromOrigin() < rhs.euclideanDistanceFromOrigin()
    }

    
    // Bonze Challenge
    static func + (lhs:Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x,
                     y: lhs.y + rhs.y)
    }
    
}

let a = Point(x: 3, y: 4)
let b = Point(x: 3, y: 4)
let abEqual = (a == b)
let abNotEqual = (a != b)

let c = Point(x: 2, y: 6)
let d = Point(x: 3, y: 7)

let cdEqual = ( c == d)
let cLessThanD = ( c < d)

let cLessThanEqualD = ( c <= d )
let cGreaterThanD = ( c > d)
let cGreaterThanEqualD = ( c >= d )


// Bonze Challenge test
let aPlutB = a + b

// Gold Ghallenge
class Person: Equatable {
    
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return ( lhs.name == rhs.name ) && ( lhs.age == rhs.age )
    }
}

// Gold Challenge test
let p1 = Person(name: "p1", age: 1)
let p2 = Person(name: "p2", age: 2)
var people = [p1, p2]
let p1Index = people.firstIndex(of: p1)

// Platinum Challenge test
let point1 = Point(x: 3, y: 4)
let point2 = Point(x: 2, y: 5)

let point1GreaterThanPoint2 = ( point1 > point2 )
let point1LessThanPoint2 = ( point1 < point2 )
let point1EqualToPoint2 = ( point1 == point2 )
