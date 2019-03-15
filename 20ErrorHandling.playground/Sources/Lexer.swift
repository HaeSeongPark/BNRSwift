import Foundation

public class Lexer {
    
    public enum Error:Swift.Error, Equatable {
        case InvalidCharacter(position:Int, invalidCharacer: Character)
    }
    
    let input: String
    var position: String.Index
    
    public init(input: String) {
        self.input = input
        self.position = self.input.startIndex
    }
    
    func peek() -> Character? {
        return position < input.endIndex ? input[position] : nil
    }
    
    func advance() {
        // first arg is condition
        // if condition is true nothing happen
        // if it's false it prints the message
        // and only when debug mode it is excuted
        // you want to do in release mode, then use precondition
        // it's for error detecting right before nonrecoverable occur
        // it helps for developer to find nonrecoverable error easily using debug mode
        assert(position < input.endIndex, "Cannot advance past endIndex!")
        position = input.index(after: position)
    }
    
    func getNumber() -> Int {
        var value = 0
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0"..."9":
                // Another digit - add into value
                let digitValue = Int(String(nextCharacter))!
                value = 10 * value + digitValue
                advance()
            default:
                // A non-digit - go back to regular lexing
                return value
            }
        }
        return value
    }
    
    
    public func lex() throws -> [Token] {
        var tokens = [Token]()
        
        while let nextCharacter = peek() {
            let distanceToPosition = input.distance(from: input.startIndex, to: position)
            
            switch nextCharacter {
            case "0"..."9":
                // start of a number - need to grab the rest
                //                let value = getNumber() // I don't like temp variable
                tokens.append(.number(value: getNumber(), position: distanceToPosition))
            case "+":
                tokens.append(.plus(position: distanceToPosition))
                advance()
            case "-":
                tokens.append(.minus(position: distanceToPosition))
                advance()
            case "*":
                tokens.append(.multiply(postion: distanceToPosition))
                advance()
            case "/":
                tokens.append(.divide(position: distanceToPosition))
                advance()
            case " ":
                // Just advance to ignore spaces
                advance()
            default:
                // like return, throw causes the function to immedatetly stop excuting and go back to its caller.
                throw Error.InvalidCharacter(position: distanceToPosition, invalidCharacer: nextCharacter)
                // something unexpected - need to send back an error
            }
        }
        return tokens
    }
}
