// Playground - noun: a place where people can play

import UIKit

enum Shape: Int{
    case Rectangle
    case Square
    case Triangle
    case Circle
}

var aShape: Shape = .Triangle
aShape = .Square
println(aShape)

var triangle = Shape.Triangle
triangle.rawValue

var square = Shape(rawValue: 1)
var notAShape = Shape(rawValue: 100)
if let ccc = notAShape {
    println("aaa")
} else {
    println("bbbb")
}