import Foundation

public class Parser {
    public enum Error: Swift.Error, Equatable {
        case UnexpectedEndOfInput
        case InvalidToken(position:Int, invalidToken: String)
    }
    
    let tokens: [Token]
    var position = 0
    
    public init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    func getNextToken() -> Token? {
        guard position < tokens.count else {
            return nil
        }
        
        let token = tokens[position]
        position += 1
        return token
    }
    
    func getNumber() throws -> Int {
        guard let token = getNextToken() else {
            throw Parser.Error.UnexpectedEndOfInput
        }
        
        switch token {
        case .number(let value, _):
            return value
        case .plus(let position):
            throw Error.InvalidToken(position:position, invalidToken: "+")
        case .minus(let position):
            throw Error.InvalidToken(position:position, invalidToken: "-")
        case .multiply(let position):
            throw Error.InvalidToken(position: position, invalidToken: "*")
        case .divide(let position):
            throw Error.InvalidToken(position: position, invalidToken: "/")
        }
    }
    
    public func parse() throws -> Int {
        // Require a number first
        var value = try getNumber()
        
        while let token = getNextToken() {
            switch token {
            // Getting a Plus after a Number is legal
            case .plus:
                // After a plus, we must get another number
                let nextNumber = try parse()
                value += nextNumber
            case .minus:
                let nextNumber = try parse()
                value -= nextNumber
            case .multiply:
                let nextNumber = try getNumber()
                value *= nextNumber
            case .divide:
                let nextNumber = try getNumber()
                value /= nextNumber
            case .number(let value, let position):
                throw Error.InvalidToken(position: position, invalidToken: String(value))
            }
        }
        return value
    }
}
