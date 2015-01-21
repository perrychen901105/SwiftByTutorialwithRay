// Playground - noun: a place where people can play

import Foundation

let words = ["Cat", "Chicken", "fish", "Dog", "Mouse", "Guinea Pig", "monkey"]

typealias Entry = (Character, [String])

func distinct<T: Equatable>(source: [T]) -> [T] {
    var unique = [T]()
    for item in source {
        if !contains(unique, item) {
            unique.append(item)
        }
    }
    return unique
}

func buildIndex(words: [String]) -> [Entry] {
    let letters = words.map {
        (word) -> Character in Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)
    }
    let distinctLetters = distinct(letters)
    println(distinctLetters)
    return distinctLetters.map {(letter) -> Entry in return (letter, [])};
}

println(buildIndex(words))



