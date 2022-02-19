//: [Previous](@previous)

import Foundation

let remindersDataURL = URL(fileURLWithPath: "Reminders",
                           relativeTo: FileManager.documentDirectoryURL)
let stringURL = FileManager.documentDirectoryURL.appendingPathComponent("String").appendingPathExtension("txt")
stringURL.path

//challenge
let challengeString:String = "To Do List"
let challengeURL: URL = URL(fileURLWithPath: challengeString, relativeTo: FileManager.documentDirectoryURL).appendingPathExtension("txt")
challengeURL.lastPathComponent
//: [Next](@next)
