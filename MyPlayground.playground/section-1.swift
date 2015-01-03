// Playground - noun: a place where people can play

import Foundation

/*
    Base
*/
//var greeting = "hello world".capitalizedString
//var alternateGreeting = greeting
//alternateGreeting += " and beyond!"
//println(alternateGreeting)
//println(greeting)
//
//var radius = 4
//let pi = 3.14159
//let million = 1_000_000
//var area = Double(radius) * Double(radius) * pi
//
//var overflow = Int.max &+ 1
//
//let alwaysTrue = true

/*
Tuple test
*/

//var address = (number: 742, street: "Evergreen Terrace")
//let (house, street) = address
//println(address.number)
//println(street)

/*
    String interpolation
*/
//var address = (742, "Evergreen Terrace")
//let (house, street) = address
//println("I live at " + String(house) + ", " + street)
//println("I live at \(house), \(street)")
//let str = "I live at \(house + 10), \(street.uppercaseString)"
//println(str)


/**
    Control Flow
*/

let greeting = "Swift by Tutorials Rocks!"
var range = Range(start: 1, end: 6) //1...5
for i in range {
    println("\(i) - \(greeting)")
    
}
