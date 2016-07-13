//
//  LDData.swift
//  LucidDreams
//
//  Created by Pablo on 7/12/16.
//
//

import Foundation
import SwiftyJSON
import Moya_SwiftyJSONMapper

class LDResponse: ALSwiftyJSONAble {
    
    var data:       Array<LDGIF> = []
    var pagination: [String: AnyObject]?
    
    required init?(jsonData:JSON) {
        
        if let data = jsonData["data"].array {
            
            for gifData in data {
                
                self.data.append(LDGIF(jsonData: gifData)!)
            }
        } else {
            return nil
        }
        
        if let pagination = jsonData["pagination"].dictionaryObject {
            
            self.pagination = pagination
        } else {
            return nil
        }
        
    }
    
}