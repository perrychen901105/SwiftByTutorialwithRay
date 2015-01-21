// Playground - noun: a place where people can play

import UIKit

let words = ["Cat", "Chicken", "fish", "Dog", "Mouse", "Guinea Pig", "monkey"]

typealias Entry = (Character, [String])
func buildIndex(words: [String]) -> [Entry] {
    var result = [Entry]()
    
    // iterates over each of the words to build an array of letters
    var letters = [Character]()
    for word in words {
        let firstLetter = Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)
    
        if !contains(letters, firstLetter) {
            letters.append(firstLetter)
        }
    }
    
    // iterates over these letters, finding the words that start with the given letter, to build the return array.
    for letter in letters {
        var wordsForLetter = [String]()
        for word in words {
            let firstLetter = Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)
            
            if firstLetter == letter {
                wordsForLetter.append(word)
            }
        }
        result.append((letter, wordsForLetter))
    }
    return result
}
println(buildIndex(words))




