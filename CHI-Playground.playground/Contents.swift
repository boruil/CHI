//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var currentDate = NSDate()

var dateAsString = "13 May 2016 05:13:33"
let dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
var newDate = dateFormatter.dateFromString(dateAsString)