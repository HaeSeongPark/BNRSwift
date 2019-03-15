import Cocoa

enum Token {
    case number(value : Int, position : Int)
    case minus(position : Int)
    case plus(position: Int)
}

class Lexer {
    
    enum Error:Swift.Error {
        case InvalidCharacter(position:Int, invalidCharacer: Character)
    }
    
    let input: String
    var position: String.Index
    
    init(input: String) {
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
    
    
    func lex() throws -> [Token] {
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

class Parser {
    enum Error: Swift.Error {
        case UnexpectedEndOfInput
        case InvalidToken(position:Int, invalidToken: String)
    }
    
    let tokens: [Token]
    var position = 0
    init(tokens: [Token]) {
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
        case .minus:
            throw Error.InvalidToken(position:position, invalidToken: "-")
        }
    }
    
    func parse() throws -> Int {
        // Require a number first
        var value = try getNumber()
        
        while let token = getNextToken() {
            switch token {
            // Getting a Plus after a Number is legal
            case .plus:
                // After a plus, we must get another number
                let nextNumber = try getNumber()
                value += nextNumber
            case .minus:
                let nextNumber = try getNumber()
                value -= nextNumber
            case .number(let value, let position):
                throw Error.InvalidToken(position: position, invalidToken: String(value))
            }
        }
        return value
    }
}

let placeHolderOfEvalute = "Evaluating: "
func emptySpace(of distanceToPosition: Int) -> String {
    return repeatElement(" ", count: placeHolderOfEvalute.count + distanceToPosition).joined(separator: "")
}

func evaluate(_ input:String) {
    print("\(placeHolderOfEvalute)\(input)")
    let lexer = Lexer(input: input)
    
//    guard let tokens = try? lexer.lex() else {
//        print("Lexing failed, but I don't know why")
//        return
//    }
    
    do {
        let tokens = try lexer.lex()
        let parser = Parser(tokens: tokens)
        let result = try parser.parse()
        print("Parser output: \(result)")
    } catch Lexer.Error.InvalidCharacter(let distanceToPosition, let char){
        print("\(emptySpace(of: distanceToPosition))^")
        print("Input contained an invalid at index \(distanceToPosition) : \(char)")
    } catch Parser.Error.UnexpectedEndOfInput {
        print("Unexpected end of input during parsing")
    } catch Parser.Error.InvalidToken(let distanceToPosition, let token) {
        print("\(emptySpace(of: distanceToPosition))^")

        print("Invalid token during parsing : \(token)")
    } catch {
        print("An error ocurred: \(error)")
    }
    print("\n--------------------------------\n")
}

evaluate("10 + 5 - 3 - 1") // should be 11
evaluate("1 + 3 + 7a + 8") // Input contained an invalid at index 9 : a
evaluate("10 + 3 + 5") // should be 18
evaluate("10 + 3 5") // Invalid token during parsing : 5
evaluate("10 + ") // Unexpected end of input during parsing
