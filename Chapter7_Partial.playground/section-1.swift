// Playground - noun: a place where people can play

import Foundation

let data = "5,7;3,4;55,6"

println(data.componentsSeparatedByString(";"))

// partial application
//func createSplitter(separator:String) -> (String -> [String]) {
//    func split(source:String) -> [String] {
//        return source.componentsSeparatedByString(separator)
//    }
//    return split
//}
//
//let commaSplitter = createSplitter(",")
//println(commaSplitter(data))
//
//let semiColonSplitter = createSplitter(";")
//println(semiColonSplitter(data))

// mild curry
func createSplitter(separator:String)(source:String) -> [String] {
    return source.componentsSeparatedByString(separator)
}

let commaSplitter = createSplitter(",")
println(commaSplitter(source: data))

let semiColonSplitter = createSplitter(";")
println(semiColonSplitter(source: data))

func addNumbers(one: Int, two: Int, three:Int) -> Int {
    return one + two + three
}

let sum = addNumbers(2, 5, 4)
println(sum)

func curryAddNumbers(one:Int)(two:Int)(three:Int) -> Int {
    return one + two + three
}

let stepOne = curryAddNumbers(2)
let stepTwo = stepOne(two: 5)
let result = stepTwo(three: 4)
println(result)

let result2 = curryAddNumbers(2)(two: 5)(three: 4)
println(result2)

func curryAddNumbers2(one:Int, two:Int)(three:Int) -> Int {
    return one + two + three
}

let result3 = curryAddNumbers2(2, 5)(three: 4)
println(result3)

let text = "Swift"
let paddedText = text.stringByPaddingToLength(10, withString: ".", startingAtIndex: 0)
println(paddedText)

func curriedPadding(startingAtIndex: Int, withString: String)(source: String, length: Int) -> String {
    return source.stringByPaddingToLength(length, withString: withString, startingAtIndex: startingAtIndex)
}

// with signature of (String, Int) -> String
let dotPadding = curriedPadding(0, ".")
let dotPadded = dotPadding(source: "Curry!", length: 10)
println(dotPadded)



