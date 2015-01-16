// Playground - noun: a place where people can play

import UIKit

enum Shape {
    case Rectangle(width: Float, height: Float)
    case Square(side: Float)
    case Triangle(base: Float, height: Float)
    case Circle(radius: Float)

    func area() -> Float {
        switch(self) {
        case .Rectangle(let width, let height):
            return width * height
        case .Square(let side):
            return side * side
        case .Triangle(let base, let height):
            return 0.5 * base * height
        case .Circle(let radius):
            return Float(M_PI) * powf(radius, 2)
        }
    }
    
    init(_ rect: CGRect) {
        let width = Float(CGRectGetWidth(rect))
        let height = Float(CGRectGetHeight(rect))
        if width == height {
            self = Square(side: width)
        } else {
            self = Rectangle(width: width, height: height)
        }
    }
    
    // called on the type rather than on an instance.
    static func fromString(string: String) -> Shape? {
        switch(string) {
            case "rectangle":
                return Rectangle(width: 5, height: 10)
            case "square":
                return Square(side: 5)
            case "triangle":
                return Triangle(base: 5, height: 10)
            case "circle":
                return Circle(radius: 5)
        default:
            return nil
        }
    }
    
}

var circle = Shape.Circle(radius: 5)
circle.area()

var shape = Shape(CGRect(x: 0, y: 0, width: 5, height: 10))
shape.area()

if let anotherShape = Shape.fromString("rectangle") {
    anotherShape.area()
}


