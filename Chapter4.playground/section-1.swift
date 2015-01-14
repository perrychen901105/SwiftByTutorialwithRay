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
struct Person {
    var age = 34, name = "Colin"
    
    mutating func growOlder() {
        self.age++
    }
}

func celebrateBirthday(inout cumpleanero: Person) {
//    cumpleanero = Person()
    println("Happy Birthday \(cumpleanero.name)")
    cumpleanero.growOlder()
}

var person = Person()
celebrateBirthday(&person)
println(person.age)

var personB = person
celebrateBirthday(&personB)
println(personB.age)




