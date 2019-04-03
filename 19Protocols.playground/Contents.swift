import Cocoa

func padding(amout: Int) -> String {
    guard amout > 0 else {
        return ""
    }
    
    var paddingString = ""
    for _ in 0 ..< amout {
        paddingString += " "
    }
    return paddingString
}

func printTable(dataSource: TabularDataSource & CustomStringConvertible ) {
    print("Table : \(dataSource.description)")
    print("=================================")
    
//    let rowLabels = (0..<dataSource.numberOfRows).map { dataSource.labelForRow(row: $0)}
    let columnLabels = (0..<dataSource.numberOfColumns).map{ dataSource.labelForColumn(column: $0)}
    
//    let rowLabelWidths = rowLabels.map { $0.count }
    
//    guard let maxRowLabelWidth = rowLabelWidths.max() else {
//        return
//    }
    
//    var firstRow = padding(amout: maxRowLabelWidth) + " |"
    var firstRow = ""
    
//    var columnWidth = [Int]()
    
    for (i, columnLabel) in columnLabels.enumerated() {
        let columnHeader = " \(columnLabel) |"
        firstRow +=  padding(amout: dataSource.maxLengthOfLabelForColumn(column: i) - columnHeader.count) + columnHeader
//        columnWidth.append(columnHeader.count)
    }
    
    print(firstRow)
    
    for i in 0 ..< dataSource.numberOfRows {
//        let paddingAmount = maxRowLabelWidth - rowLabelWidths[i]
//        var out = rowLabels[i] + padding(amout: paddingAmount) + " |"
        var out = ""
        
        for j in 0 ..< dataSource.numberOfColumns {
            let item = dataSource.itemForRow(row: i, column: j)
            let itemString = " \(item) |"
//            let paddingAmount = columnWidth[j] - itemString.count
            let paddingAmount = dataSource.maxLengthOfLabelForColumn(column: j) - itemString.count
            out += padding(amout: paddingAmount) + itemString
        }
        
        print(out)
    }
}

//let rowLabels = ["Joe", "Karen", "Fred"]
//let columnLabels = ["Age", "Years of Experience"]
//let data = [
//    [30, 6],
//    [40, 18],
//    [50,20]
//]
//
//printTable(rowLabels: rowLabels, columnLabls:  columnLabels, data: data)

protocol TabularDataSource {
    var numberOfRows: Int { get }
    var numberOfColumns: Int { get }
    
    func labelForRow(row: Int) -> String
    func labelForColumn(column: Int) -> String
    func maxLengthOfLabelForColumn(column:Int) -> Int
    
    func itemForRow(row: Int, column: Int) -> String
}

struct Person {
    let name: String
    let age: Int
    let yearsOfExperience: Int
    
    subscript(index: Int) -> String {
        switch index {
        case 0: return name
        case 1: return age.description
        case 2: return yearsOfExperience.description
        default: fatalError("Invalid column!")
        }
    }
}

struct Department: TabularDataSource, CustomStringConvertible {
    
    let columnLabels = ["Name","Age", "Years of Years of Experience"]
    
    var description: String {
        return "Department (\(name))"
    }
    
    var numberOfRows: Int {
        return people.count
    }
    
    var numberOfColumns: Int {
        return columnLabels.count
    }
    
    
    func labelForRow(row: Int) -> String {
        return people[row].name
    }
    
    func labelForColumn(column: Int) -> String {
        // need validate column
        return columnLabels[column]
    }
    
    func maxLengthOfLabelForColumn(column:Int) -> Int {
        let extraPadding = 3
        var result = columnLabels[column].count

        for person in people {
            if person[column].count > result {
                result = person[column].count
            }
        }
        
        return result + extraPadding
    }
    
    func itemForRow(row: Int, column: Int) -> String {
        return people[row][column]
    }
    
    let name: String
    var people = [Person]()
    
    init(name: String) {
        self.name = name
    }
    
    mutating func addPerson(person:Person) {
        people.append(person)
    }
}

var department = Department(name: "Engineering")
department.addPerson(person: Person(name: "Joe", age: 30, yearsOfExperience: 6))
department.addPerson(person: Person(name: "Karen", age: 40, yearsOfExperience: 18))
department.addPerson(person: Person(name: "Fred", age: 50, yearsOfExperience: 20))

printTable(dataSource: department)

//////

protocol Toggleable {
   mutating func toggle()
}

enum Lightbulb: Toggleable {
    case On
    case Off
    mutating func toggle() {
        switch self {
        case .On:
            self = .Off
        case .Off:
            self = .On
        }
    }
}

struct Book {
    let title: String
    let author: String
    let averageReview: Int
    
    subscript(index: Int) -> String {
        switch index {
        case 0: return title
        case 1: return author
        case 2: return averageReview.description
        default: fatalError("Invalid column!")
        }
    }
}


struct BookCollection: TabularDataSource, CustomStringConvertible {
    var description: String {
        return "Book Collection"
    }
    

    let columnLabels = ["Title", "Author", "AverageReviews"]

    var numberOfRows: Int {
        return books.count
    }

    var numberOfColumns: Int {
        return columnLabels.count
    }


    func labelForRow(row: Int) -> String {
        return books[row].title
    }

    func labelForColumn(column: Int) -> String {
        // need validate column
        return columnLabels[column]
    }

    func maxLengthOfLabelForColumn(column:Int) -> Int {
        let extraPadding = 3
        var result = columnLabels[column].count

//        switch column {
//        case 0:
//            for book in books {
//                if book.title.count > result {
//                    result = book.title.description.count
//                }
//            }
//        case 1:
//            for book in books {
//                if book.author.count > result {
//                    result = book.author.description.count
//                }
//            }
//        case 2:
//            for book in books {
//                if book.averageReview.description.count > result {
//                    result = book.averageReview.description.count
//                }
//            }
//        default:
//            return 0 //error
//        }
        
       for book in books {
            if book[column].count > result {
                result = book[column].count
            }
        }

        return result + extraPadding
    }

    func itemForRow(row: Int, column: Int) -> String {
        return books[row][column]
//        let book = books[row]
//        switch column {
//        case 0: return book.title
//        case 1: return book.author
//        case 2: return book.averageReview.description
//        default: fatalError("Invalid column!")
//        }
    }

    var books = [Book]()

    init(books: [Book]) {
        self.books = books
    }
}


let books = [Book(title: "title", author: "author", averageReview: 5),
Book(title: "title", author: "author", averageReview: 5),
Book(title: "title", author: "author", averageReview: 5)]

let bookCollection = BookCollection(books: books)
printTable(dataSource: bookCollection)
