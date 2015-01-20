// Playground - noun: a place where people can play

import UIKit

var evens = [Int]()
for i in 1...10
{
    if i % 2 == 0
    {
        evens.append(i)
    }
}
println(evens)

func isEven(number: Int) -> Bool {
    return number % 2 == 0
}
evens = Array(1...10).filter(isEven)
println(evens)

evens = Array(1...10).filter { (number) in number % 2 == 0}
println(evens)

evens = Array(1...10).filter { $0 % 2 == 0 }
println(evens)

func myFilter<T>(source: [T], predicate:(T) -> Bool) -> [T] {
    var result = [T]()
    for i in source {
        if predicate(i) {
            result.append(i)
        }
    }
    return result
}

evens = myFilter(Array(1...10)) {
    $0 % 2 == 0
}
println(evens)


