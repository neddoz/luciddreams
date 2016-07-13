//
//  LDImage.swift
//  LucidDreams
//
//  Created by Pablo on 7/13/16.
//
//

import Foundation
import SwiftyJSON
import Moya_SwiftyJSONMapper

class LDImage: ALSwiftyJSONAble {
    
    var url:    NSURL
    var width:  NSNumber
    var height: NSNumber
    
    required init?(jsonData:JSON) {
        
        if let url = jsonData["url"].string {
            
            self.url = NSURL(string: url)!
        } else {
            return nil
        }
        
        if let width = jsonData["width"].string {
            
            self.width = Int(width)!
        } else {
            return nil
        }
        
        if let height = jsonData["height"].string {
            
            self.height = Int(height)!
        } else {
            return nil
        }
        
    }
    
}