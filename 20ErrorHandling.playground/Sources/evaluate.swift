import Foundation

let placeHolderOfEvalute = "Evaluating: "
func emptySpace(of distanceToPosition: Int) -> String {
    return repeatElement(" ", count: placeHolderOfEvalute.count + distanceToPosition).joined(separator: "")
}

public func evaluate(_ input:String) {
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
