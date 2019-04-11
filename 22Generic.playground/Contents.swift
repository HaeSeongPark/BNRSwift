import Cocoa


struct StackIterator<T>: IteratorProtocol{
    var stack: Stack<T>
    mutating func next() -> T?{
        return stack.pop()
    }
}


struct Stack<Element>: Sequence {
    
    var items = [Element]()
    
    mutating func push(_ newItem:Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
    
    func map<U>(_ f: (Element) -> U) -> Stack<U> {
        var mappdItems = [U]()
        for item in items {
            mappdItems.append(f(item))
        }
        return Stack<U>(items: mappdItems)
    }
    
    func makeIterator() -> StackIterator<Element>{
        return StackIterator(stack:self)
    }
}

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
var doubledStack = intStack.map { $0 * 2 }

print(intStack.pop())
print(intStack.pop())
print(intStack.pop())

print(doubledStack.pop())
print(doubledStack.pop())

var stringStack = Stack<String>()
stringStack.push("this is a string")
stringStack.push("another string")
print(stringStack.pop())

func myMap<T, U>(_ items:[T], f:(T) -> (U)) -> [U] {
    var result = [U]()
    for item in items {
        result.append(f(item))
    }
    return result
}

let strings = ["one", "two","three"]
let stringLenghts = myMap(strings) { $0.count }
print(stringLenghts)

func checkIfEqual<T:Equatable>(_ first:T, _ second:T) -> Bool{
    return first == second
}

print(checkIfEqual(1, 1))
print(checkIfEqual("a string", "a string"))
print(checkIfEqual("a string", "a different string"))

func CheckIfDescriptionsMatch<T:CustomStringConvertible, U:CustomStringConvertible>(_ first:T, _ second:U) -> Bool{
    return first.description == second.description
}

//func CheckIfDescriptionsMatch<T:CustomStringConvertible>(_ first:T, _ second:T) -> Bool{
//    return first.description == second.description
//}

print(CheckIfDescriptionsMatch(Int(1), UInt(1)))
print(CheckIfDescriptionsMatch(1, 1.0))
print(CheckIfDescriptionsMatch(Float(1.0), Double(1.0)))

var myStack = Stack<Int>()
myStack.push(10)
myStack.push(20)
myStack.push(30)

var myStackIterator = StackIterator(stack: myStack)
while let value = myStackIterator.next() {
    print("got \(value)")
}


for value in myStack {
    print("for-in loop: got \(value)")
}

//func pushItemsOntoStack<Element>( stack: inout Stack<Element>,
//                                       fromArray array: [Element]) {
//    for item in array {
//        stack.push(item)
//    }
//}
//
//pushItemsOntoStack(stack: &myStack, fromArray: [1,2,3])
//for value in myStack {
//    print("After pushing : got \(value)")
//}

func pushItemsOntoStack<Element, S: Sequence>( stack: inout Stack<Element>,
                                               fromSqequence sequence:S) where S.Iterator.Element == Element {
    for item in sequence {
        stack.push(item)
    }
}

pushItemsOntoStack(stack: &myStack, fromSqequence: [1,2,3])
for value in myStack {
    print("After pushing : got \(value)")
}
