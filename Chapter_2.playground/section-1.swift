// Playground - noun: a place where people can play

import UIKit

/*
    optional wrap
*/
//var str : String?
//if let unwrappedStr = str {
//    println("Unwrapped: \(unwrappedStr.uppercaseString)")
//} else {
//    println("Was nil")
//}
//
//if str != nil {
//    println("not nil")
//} else {
//    println("nil")
//}
/*
    forced unwarpping
*/
//var str: String? = "Hello Swift by Tutorials!"
//println("Forced unwrapping! \(str!.uppercaseString)")

/*
    Implicit unwrapping
*/
//var str: String!
//str = str.lowercaseString
//println(str)
//
//if str != nil {
//    str = str.lowercaseString
//    println(str)
//}

/*
    Optional chaining
*/
//var maybeString: String? = "Hello Swift by Tutorials!"
//let uppercase = maybeString?.uppercaseString
//println(uppercase)

/*
    Collections
*/
//var array: [Int] = [1, 2, 3, 4, 5]
//println(array[2])
//array.append(6)
//array.extend(7...10)
//println(array)


//var dictionary: [Int:String] = [1: "Dog",2: "Cat"]
//println(dictionary[2])
//dictionary[3] = "Mouse"
//
//dictionary[2] = "Elephant"
//dictionary[3] = nil
//println(dictionary)

/*
    References and copies
*/
//var dictionaryA = [1: 1, 2: 4, 3: 9, 4: 16]
//var dictionaryB = dictionaryA
//println(dictionaryA)
//println(dictionaryB)
//dictionaryB[4] = nil
//println(dictionaryA)
//println(dictionaryB)
//
//var arrayA = [1,2,3,4,5]
//var arrayB = arrayA
//arrayB[1] = 10
//arrayB
//arrayA

/*
    Constant collections
*/
let constantArray = [1, 2, 3, 4, 5]





