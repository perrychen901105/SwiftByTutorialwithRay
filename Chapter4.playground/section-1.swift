// Playground - noun: a place where people can play

import Foundation

/*
func square(number: Double) -> Double {
    return number * number
}

let operation:(Double) -> Double = square

let a = 3.0, b = 4.0
let c = sqrt(operation(a) + operation(b))
println(c)

func logDouble(number:Double) {
    println(String(format: "%.2f", number))
}
logDouble(c)
*/

/*
// generic
//func checkAreEqual(value: Int, expected: Int, message: String) {
//    if expected != value {
//        println(message)
//    }
//}
//
//func checkAreEqual(value: String, expected: String, message: String) {
//    if expected != value {
//        println(message)
//    }
//}

func checkAreEqual<T: Equatable>(value: T, expected: T, message: String) {
    if expected != value {
        println(message)
    }
}

var input = 3
checkAreEqual(input, 2, "An input value of '2' was expected")

input = 47
checkAreEqual(input, 47, "An input value of '47' was expected")

var inString = "cat"
checkAreEqual(inString, "dog", "An input value of 'dog' was expected")
*/

/**
*  In-out variables
*/
/*
func square(inout number: Double) {
    number = number * number
}

var a = 2.0
square(&a)
println(a)
*/

/**
*  classes and structures as function parameters
*/
//struct Person {
//    var age = 34, name = "Colin"
//    
//    mutating func growOlder() {
//        self.age++
//    }
//}
//
//func celebrateBirthday(inout cumpleanero: Person) {
////    cumpleanero = Person()
//    println("Happy Birthday \(cumpleanero.name)")
//    cumpleanero.growOlder()
//}
//
//var person = Person()
//celebrateBirthday(&person)
//println(person.age)

/**
*  Variadic
*/
//func longestWord(copareWord words: String...) -> String? {
//    var currentLongest: String?
//    for word in words {
//        if currentLongest != nil {
//            if countElements(word) > countElements(currentLongest!) {
//                currentLongest = word
//            }
//        } else {
//            currentLongest = word
//        }
//    }
//    return currentLongest
//}
//
//let long = longestWord(copareWord: "chick", "fish", "cat", "elephant")
//println(long)

/**
*  External parameter names
*/
//func checkAreEqual(value val: String, expected exp: String, message msg: String) {
//    if exp != val {
//        println(msg)
//    }
//}

//func checkAreEqual(#value: String, #expected: String, #message: String) {
//    if expected != value {
//        println(message)
//    }
//}
//
//checkAreEqual(value: "cat", expected: "dog", message: "Incorrect input")


/**
*  Methods
*  Instance methods
*/

//class Cell: Printable {
//    private(set) var row = 0
//    private(set) var column = 0
//    
////    func move(x: Int, _ y: Int) {
////    func move(x: Int, y: Int) {
//    func move(x: Int = 0, y: Int = 0) {
//        row += y
//        column += x
//    }
//
//    func moveByX(x: Int) {
//        column += x
//    }
//    
//    func moveByY(y: Int) {
//        row += y
//    }
//    
//    var description: String {
//        get {
//            return "Cell [row = \(row), col = \(column)]"
//        }
//    }
//}
//
////var cell = Cell()
////cell.moveByX(4)
////cell.move(x: 4, y: 7)
////cell.moveByX(2)
////cell.moveByY(3)
////println(cell.description)
//
////var cell = Cell()
////var instanceFunc = cell.moveByY
////instanceFunc(34)
////println(cell.description)
//
//var cell = Cell()
//var moveFunc = Cell.moveByY
//moveFunc(cell)(34)
//println(cell.description)

/**
*  Clousures
*/
//let animals: [String] = ["fish", "cat", "chicken", "dog"]
//func isBefore(one: String, two: String) -> Bool {
//    return one > two
//}
//
////let sortedStrings = animals.sorted(isBefore)
////println(sortedStrings)
//
////let sortedStringsWithClousure = animals.sorted { (one: String, two: String) -> Bool in
////    return one > two
////}
//
//let sortedStringsWithClosure = animals.sorted(>)

/**
*  Capturing values
*/
typealias StateMachineType = () -> Int

func makeStateMachine(maxState: Int) -> StateMachineType {
    var currentState: Int = 0
    return {
        currentState++
        if currentState > maxState {
            currentState = 0
        }
        return currentState
    }
}

let tristate = makeStateMachine(2)
println(tristate())
println(tristate())
println(tristate())
println(tristate())
println(tristate())
println(tristate())
println(tristate())
println(tristate())


