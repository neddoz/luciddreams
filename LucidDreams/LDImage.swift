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
    
    var data: [String: AnyObject]?
    
    required init?(jsonData:JSON) {
        
        if let data = jsonData["fixed_height_downsampled"].dictionaryObject {
            
            self.data = data
            
            print(data)
        } else {
            return nil
        }
        
//        if let data = jsonData["data"].array {
//            
//            for gifData in data {
//                
//                self.data.append(LDGIF(jsonData: gifData)!)
//            }
//        } else {
//            return nil
//        }
//        
//        if let pagination = jsonData["pagination"].dictionaryObject {
//            
//            self.pagination = pagination
//        } else {
//            return nil
//        }
        
    }
    
}