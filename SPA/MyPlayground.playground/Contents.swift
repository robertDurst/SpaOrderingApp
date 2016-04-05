//: Playground - noun: a place where people can play

import UIKit

var bob = String([["Cheese Quesadilla", "5", "1"], ["Chicken Fritter", "5", "1"]])



var stepper = 0
var word = ""
var words: [String] = []

for i in bob.characters{
    if (i == "," || i == "]" || i == "[") && word.characters.count > 2{
        words.append(word)
        word = ""
    }
    else if stepper > 2{
       word.append(i)
    }
    stepper += 1
}
for i in words{
    print(i)
}
