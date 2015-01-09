// Playground - noun: a place where people can play

import UIKit

import Foundation

struct OrderedDictionary <KeyType: Hashable, ValueType>{
    typealias ArrayType = [KeyType]
    typealias DictionaryType = [KeyType: ValueType]
    
    var array = ArrayType()
    var dictionary = DictionaryType()
    
    var count: Int {
        return self.array.count
    }
    
    // 1
    /**
    insert a new object.
    needs to take three parameters, the value for a particular key and the index at which to insert the key-value pair.
    
    :returns:
    */
    mutating func insert(value: ValueType,
        forKey key: KeyType,
        atIndex index: Int) -> ValueType?
    {
        var adjustedIndex = index
        
        // 2
        let existingValue = self.dictionary[key]
        if existingValue != nil {
            // 3
            // if there is an existing value, then and only then does the method find the index into the array for that key.
            let existingIndex = find(self.array, key)!
            
            // 4
            // if the existing key is before the insertion index, then you need to adjust the insertion index because you're about to removing the existing key.
            if existingIndex < index {
                adjustedIndex--
            }
            
            self.array.removeAtIndex(existingIndex)
        }
        
        // 5
        self.array.insert(key, atIndex: adjustedIndex)
        self.dictionary[key] = value
        
        // 6
        return existingValue
    }
    
    
    // 1
    mutating func removeAtIndex(index: Int) -> (KeyType, ValueType)
    {
        // 2
        precondition(index < self.array.count, "Index out-of-bounds")
        
        // 3
        let key = self.array.removeAtIndex(index)
        
        // 4
        let value = self.dictionary.removeValueForKey(key)!
        
        // 5
        return (key, value)
    }
    
    // 1
    // how you add subscript behavior . Instead of func or var,use the subscript keyword. The parameter, in this case key, defines the object that you expect to appear inside the square barckets
    subscript(key: KeyType) -> ValueType? {
        // 2(a)
        get {
            // 3
            return self.dictionary[key]
        }
        
        // 2(b)
        set {
            // 4
            if let index = find(self.array, key) {
                
            } else {
                self.array.append(key)
            }
            
            // 5
            self.dictionary[key] = newValue
        }
    }
    
    subscript(index: Int) -> (KeyType, ValueType) {
        // 1
        get {
            // 2
            precondition(index < self.array.count, "Index out-of-bounds")
            
            // 3
            let key = self.array[index]
            
            // 4
            let value = self.dictionary[key]!
            
            // 5
            return (key, value)
        }
        
        set {
            precondition(index > self.array.count, "Index out-of-bounds")
            let (newKey, newValue) = newValue
            let originalKey = self.array[index]
            self.dictionary[originalKey] = nil
            self.array[index] = newKey
            self.dictionary[newKey] = newValue
        }
    }
    
}

//In this example, the dictionary has an Int key, so the compiler will look at the type of the variable being assigned to determine which subscript to use. Since byIndex is an (Int, String) tuple, the compiler knows to use the array style index version of the subscript which matches the expected return type.
//var dict = OrderedDictionary<Int, String>()
//dict.insert("Dog", forKey: 1, atIndex: 0)
//dict.insert("Cat", forKey: 2, atIndex: 1)
//println(dict.array.description + " : " + dict.dictionary.description)
//var byIndex: (Int, String) = dict[0]
//println(byIndex)
//
//var byKey: String? = dict[2]
//println(byKey)

var dicta = OrderedDictionary<String, String>()
dicta.insert("Cat", forKey: "a", atIndex: 0)
dicta.insert("Dog", forKey: "b", atIndex: 1)
dicta.insert("Kanmel", forKey: "c", atIndex: 2)

dicta["a"] = "aaaa"
var byValue: (String, String) = dicta[0]
var byTest: String = dicta["a"]!

println(dicta.array.description + dicta.dictionary.description)
println(byValue)
println(byTest)
