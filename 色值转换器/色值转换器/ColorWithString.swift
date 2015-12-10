//
//  ColorWithString.swift
//  色值转换器
//
//  Created by qkg on 15/12/9.
//  Copyright © 2015年 qkg. All rights reserved.
//

import UIKit

extension UIColor {
    
    //十六进制色值转换器--
    class func colorWithString(color:String) -> UIColor {
        
        var str = color.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        if str.characters.count < 6 {
            return UIColor.clearColor()
        }
      
        if str.hasPrefix("0X") {
            str = str.substringFromIndex(str.startIndex.advancedBy(2))
        }
        
        if str.hasPrefix("#") {
            str = str.substringFromIndex(str.startIndex.advancedBy(1))
        }
        
        if str.characters.count != 6 {
            return UIColor.clearColor()
        }
        
        var the = Range(start: str.startIndex, end: str.startIndex.advancedBy(2))
        let redStr = str.substringWithRange(the)
        the.startIndex = str.startIndex.advancedBy(2)
        the.endIndex = str.startIndex.advancedBy(4)
        let greenStr = str.substringWithRange(the)
        the.startIndex = str.startIndex.advancedBy(4)
        the.endIndex = str.startIndex.advancedBy(6)
        let blueStr = str.substringWithRange(the)
        
        var red : Int = 0
        var green : Int = 0
        var blue : Int = 0
        
        red = redStr.hex2dec()
        green = greenStr.hex2dec()
        blue = blueStr.hex2dec()
        
        return UIColor(red: doubleToCGFloat(red), green: doubleToCGFloat(green), blue: doubleToCGFloat(blue), alpha: 1)
    }
    
    private class func doubleToCGFloat(up:Int) -> CGFloat {
        
        return CGFloat(Double(up)/Double(255))
    }
    
}


extension String {
    
    //十六进制 转换成 二进制 ---
    func hex2dec() -> Int {
        let str = self.uppercaseString
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum -= 7
            }
        }
        return sum
    }
}
