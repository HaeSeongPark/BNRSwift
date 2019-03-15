import Cocoa

enum Token {
    case number(Int)
    //For Bronze Challenge
    case minus
    case plus
}

class Lexer {
    
    enum Error:Swift.Error {
        case InvalidCharacter(Character)
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
    
    
    func lext() throws -> [Token] {
        var tokens = [Token]()
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0"..."9":
                // start of a number - need to grab the rest
//                let value = getNumber() // I don't like temp variable
                tokens.append(.number(getNumber()))
            case "+":
                tokens.append(.plus)
                advance()
// For Bronze Challenge
            case "-":
                tokens.append(.minus)
                advance()
            case " ":
                // Just advance to ignore spaces
                advance()
            default:
                print("")
                // like return, throw causes the function to immedatetly stop excuting and go back to its caller.
                throw Error.InvalidCharacter(nextCharacter)
                // something unexpected - need to send back an error
            }
        }
        return tokens
    }
}

class Parser {
    enum Error: Swift.Error {
        case UnexpectedEndOfInput
        case InvalidToken(Token)
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
        case .number(let value):
            return value
        case .plus:
            throw Error.InvalidToken(token)
        case .minus:
            throw Error.InvalidToken(token)
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
// For Bronze Challenge
            case .minus:
                let nextNumber = try getNumber()
                value -= nextNumber
            case .number:
                throw Error.InvalidToken(token)
            }
        }
        return value
    }
}

func evaluate(_ input:String) {
    print("Evaluating: \(input)")
    let lexer = Lexer(input: input)
    
//    guard let tokens = try? lexer.lex() else {
//        print("Lexing failed, but I don't know why")
//        return
//    }
    
    do {
        let tokens = try lexer.lext()
        print("Lexer output: \(tokens)")
        
        let parser = Parser(tokens: tokens)
        let result = try parser.parse()
        print("Parser output: \(result)")
    } catch Lexer.Error.InvalidCharacter(let char){
        print("Input contained an invalid chracter: \(char)")
    } catch Parser.Error.UnexpectedEndOfInput {
        print("Unexpected end of input during parsing")
    } catch Parser.Error.InvalidToken(let token) {
        print("Invalid token during parsing : \(token)")
    } catch {
        print("An error ocurred: \(error)")
    }
}
// For Bronze Challenge
evaluate("10 + 5 - 3 - 1") // should be 11

evaluate("10 + 3 + 5") // should be 18
evaluate("10 + 3 5") // Invalid token during paring : number(5)
evaluate("10 + ") // Unexpected end of input during parsing
