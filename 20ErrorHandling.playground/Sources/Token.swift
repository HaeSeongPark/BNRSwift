import Foundation

public enum Token {
    case number(value : Int, position : Int)
    case minus(position : Int)
    case plus(position: Int)
    case multiply(postion : Int)
    case divide(position : Int)
}
