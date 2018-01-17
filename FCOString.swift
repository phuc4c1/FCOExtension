//
//  FCOString.swift
//  FCO Extension
//
//  Created by Nguyễn Tấn Phúc on 1/2/18.
//  Copyright © 2018 Nguyễn Tấn Phúc. All rights reserved.
//

import Foundation

extension String {
    // MARK: - Remove or adding string
    func removeNonDigits() -> String{
        var i = 0
        var numberText = ""
        
        while (i < self.count) {
            let start = self.index(self.startIndex, offsetBy: i )
            let end = self.index(self.startIndex, offsetBy: i + 1)
            
            let checkString = self[start..<end]
            if (String(checkString).isNumber() == true) {
                numberText = numberText + checkString
            }
            
            i = i + 1
        }
        
        return numberText
    }
    
    func removeNonHexadecimal() -> String{
        var i = 0
        var numberText = ""
        
        while (i < self.count) {
            let start = self.index(self.startIndex, offsetBy: i )
            let end = self.index(self.startIndex, offsetBy: i + 1)
            
            let checkString = self[start..<end]
            if (String(checkString).isHexadecimal() == true) {
                numberText = numberText + checkString
            }
            
            i = i + 1
        }
        
        return numberText
    }
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters as CharacterSet)
    }
    
    func insert(_ inserString: String, afterNumberChar numberChar: Int) -> String {
        if (numberChar <= 0 || numberChar >= self.count) {
            return self
        }
        
        var newString = ""
        
        var i = 0
        while (i < self.count) {
            let start = self.index(self.startIndex, offsetBy: i)
            
            let endIndex = (i + numberChar > self.count) ? self.count : i + numberChar
            let end = self.index(self.startIndex, offsetBy: endIndex)
            
            let subString = self[start..<end]
            
            if (i == 0) {
                // First insert
                newString = newString + subString
            } else {
                newString = newString + inserString + subString
            }
            
            i = i + numberChar
        }
        
        return newString
    }
    
    // MARK: - Modify String
    func reformatAsVisaCardNumber() -> String{
        var textWithoutSpace = self.removeNonDigits()
        
        // 19 is maximum visa number
        let maxChar = 19
        if (textWithoutSpace.count > maxChar) {
            let end = textWithoutSpace.index(textWithoutSpace.startIndex, offsetBy: maxChar)
            
            textWithoutSpace = String(textWithoutSpace[..<end])
        }
        
        let textWithSpace = textWithoutSpace.insert(" ", afterNumberChar: 4)
        
        return textWithSpace
    }
    
    func reformatAsExpireMonthYear() -> String{
        var textWithoutSlash = self.removeNonDigits()
        
        // 4 is maximum expire number
        let maxChar = 4
        if (textWithoutSlash.count > maxChar) {
            let end = textWithoutSlash.index(textWithoutSlash.startIndex, offsetBy: maxChar)
            
            textWithoutSlash = String(textWithoutSlash[..<end])
        }
        
        let textWithSlash = textWithoutSlash.insert("/", afterNumberChar: 2)
        
        return textWithSlash
    }
    
    func reformatAsCVC() {
//        var text = self.removeNonDigits()
//        
//        // 3 is maximum CVC number
//        let maxChar = 3
//        if (text!.count > maxChar) {
//            let end = text!.index(text!.startIndex, offsetBy: maxChar)
//            text = text!.substring(to: end)
//        }
//        
//        self.text = text
    }
    
    // MARK: - Check String
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
    
    func isEmailFormat() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
