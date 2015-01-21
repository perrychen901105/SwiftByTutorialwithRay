// Playground - noun: a place where people can play

import UIKit

var evens = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}

var evenSum = 0
for i in evens {
    evenSum += i
}

println(evenSum)

evenSum = Array(1...10)
    .filter { (number) in number % 2 == 0}
    .reduce(0) { (total, number) in total + number }
println(evenSum)

let numbers = Array(1...10)
.reduce("numbers: ", combine: { (total, number) in
    total + "\(number) "
})

println(numbers)

let digits = [String](arrayLiteral: "3","1","4","1").reduce("", combine: { (total, number) -> String in
    total + "\(number)"
})
println(digits)

extension Array {
    func myReduce<T, U>(seed:U, combiner:(U,T) -> U) -> U) {
    var current = seed
    for item in self {
    current = combiner(current, item as T)
    }
    return current
    }
}



