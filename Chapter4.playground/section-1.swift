// Playground - noun: a place where people can play

import Foundation

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
