//
//  FCOString.swift
//  FCO Extension
//
//  Created by Nguyễn Tấn Phúc on 1/2/18.
//  Copyright © 2018 Nguyễn Tấn Phúc. All rights reserved.
//

import Foundation

extension String {
    func removeNonDigits() -> String{
        var i = 0
        var numberText = ""
        
        while (i < self.count) {
            let start = self.index(self.startIndex, offsetBy: i )
            var checkString = self.substring(from: start)
            
            let end = checkString.index(checkString.startIndex, offsetBy: 1)
            checkString = checkString.substring(to: end)
            if (checkString.isHexadecimal() == true) {
                numberText = numberText + checkString
            }
            
            i = i + 1
        }
        
        return numberText
    }
    
    func isNumber() -> Bool {
        do {
            let numberRegex = try NSRegularExpression(pattern: "[0-9]", options:.caseInsensitive)
            let numberString = self as NSString
            let results = numberRegex.matches(in: self, options: [], range: NSMakeRange(0, numberString.length))
            
            if results.count == numberString.length {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func isHexadecimal() -> Bool {
        do {
            let numberRegex = try NSRegularExpression(pattern: "[0123456789ABCDEF]", options:.caseInsensitive)
            let numberString = self.uppercased() as NSString
            let results = numberRegex.matches(in: self, options: [], range: NSMakeRange(0, numberString.length))
            
            if results.count == numberString.length {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
