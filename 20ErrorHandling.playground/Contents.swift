import Cocoa
import XCTest

// evaluate("10 + 3 + 5") // 18
// evaluate("5 - 5") // 0
// evaluate("10 * 4 + 9 / 3 - 3") // 40
// evaluate("10 * 4 + 9 / 3 / 3") // 41
// evaluate("1 + 3 + 7a + 8") // Input contained an invalid at index 9 : a
// evaluate("10 + 3 5") // Invalid token during parsing : 5
// evaluate("10 + ") // Unexpected end of input during parsing


public class Tests: XCTestCase {
    func testAdd() {
        let lexer = Lexer(input: "10 + 3 + 5")
        let tokens = try! lexer.lex()
        let parseer = Parser(tokens: tokens)
        let result = try! parseer.parse()
        XCTAssertEqual(18, result)
    }
    
    func testSubtract() {
        let lexer = Lexer(input: "5 - 5")
        let tokens = try! lexer.lex()
        let parseer = Parser(tokens: tokens)
        let result = try! parseer.parse()
        XCTAssertEqual(0, result)
    }
    
    func testAddAndSubtract() {
        let lexer = Lexer(input: "10 + 5 -3 -1")
        let tokens = try! lexer.lex()
        let parser = Parser(tokens: tokens)
        let result = try! parser.parse()
        XCTAssertEqual(11, result)
    }
    
    func testAllOperation1() {
        let lexer = Lexer(input: "10 * 4 + 9 / 3 - 3")
        let tokens = try! lexer.lex()
        let parser = Parser(tokens: tokens)
        let result = try! parser.parse()
        XCTAssertEqual(40, result)
    }
    
    func testAllOperation2() {
        let lexer = Lexer(input: "10 * 4 + 9 / 3 / 3 - 1")
        let tokens = try! lexer.lex()
        let parser = Parser(tokens: tokens)
        let result = try! parser.parse()
        XCTAssertEqual(40, result)
    }
    
    
    func testLexerErrorInvalidCharacter() {
        let lexer = Lexer(input: "1 + 3 + 7a + 8")
        XCTAssertThrowsError(try lexer.lex(), "") { (error) in
            XCTAssertEqual(error as! Lexer.Error, Lexer.Error.InvalidCharacter(position: 9, invalidCharacer: "a"))
        }
    }
    
    func testParserErrorUnexpectedEndOfInput() {
        let lexer = Lexer(input: "10 + ")
        let tokens = try! lexer.lex()
        let parser = Parser(tokens: tokens)
        XCTAssertThrowsError(try parser.parse(), "") { (error) in
            XCTAssertEqual(error as! Parser.Error, Parser.Error.UnexpectedEndOfInput)
        }
    }
    
    func testParserErrorInvalidToken() {
        let lexer = Lexer(input: "10 + 3 5")
        let tokens = try! lexer.lex()
        let parser = Parser(tokens: tokens)
        XCTAssertThrowsError(try parser.parse(), "") { (error) in
            XCTAssertEqual(error as! Parser.Error, Parser.Error.InvalidToken(position: 7, invalidToken: "5"))
        }
    }
}

Tests.defaultTestSuite.run()
