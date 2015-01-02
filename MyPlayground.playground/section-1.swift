// Playground - noun: a place where people can play

import Foundation

var greeting = "hello world".capitalizedString
var alternateGreeting = greeting
alternateGreeting += " and beyond!"
println(alternateGreeting)
println(greeting)

var radius = 4
let pi = 3.14159
let million = 1_000_000
var area = Double(radius) * Double(radius) * pi

var overflow = Int.max &+ 1

let alwaysTrue = true

var address = (742, "Evergreen Terrace")
println(address.0)
println(address.1)
