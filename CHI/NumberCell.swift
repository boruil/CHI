//
//  NumberCell.swift
//  HKTutorialPrototype
//
//  Created by ernesto on 18/10/14.
//  Copyright (c) 2014 cocoawithchurros. All rights reserved.
//
//  Modified and reused by Borui Li

import UIKit

class NumberCell: UITableViewCell {
    
    @IBOutlet var numberTextField:UITextField!
    
    var doubleValue:Double {
        get {
            let numberString:NSString = NSString(string:numberTextField.text!)
            return numberString.doubleValue;
        }
    }
}


