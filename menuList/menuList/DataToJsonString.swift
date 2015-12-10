//
//  DataToJsonString.swift
//  menuList
//
//  Created by qkg on 15/11/7.
//  Copyright © 2015年 qkg. All rights reserved.
//

import UIKit

class DataToJsonString: NSObject {
    
    
    class func dataToJsonString(object:AnyObject) -> String? {
        
        var data : NSData?
        do{
            data = try NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.init(rawValue: 0))
        }catch{
            
        }
        
        if let temp = data {
            
            let jsonStr = String(data: temp, encoding: NSUTF8StringEncoding)
            print("jsonStr ===\(jsonStr)")
            return jsonStr
        }else{
            return nil
        }
    }

}
