// Playground - noun: a place where people can play

import UIKit

enum Shape {
    case Rectangle
    case Square
    case Triangle
    case Circle
}

var aShape = Shape.Rectangle
switch(aShape) {
case .Rectangle, .Square:
    println("This is a quadrilateral")
case .Circle:
    println("This is a circle")
default:
    break
}
