//
//  LDGIF.swift
//  LucidDreams
//
//  Created by Pablo Epíscopo on 7/12/16.
//
//

import SwiftyJSON
import Moya_SwiftyJSONMapper

class LDGIF: ALSwiftyJSONAble {
    
    var gifId:            String
    var slug:             String
    var trendingDatetime: NSDate
    var image:            LDImage?
    
    required init?(jsonData: JSON) {
        
        if let gifId = jsonData["id"].string {
            
            self.gifId = gifId
        } else {
            return nil
        }
        
        if let slug = jsonData["slug"].string {
            
            self.slug = slug
        } else {
            return nil
        }
        
        if jsonData["trending_datetime"].string != nil {
            
            self.trendingDatetime = NSDate()
        } else {
            return nil
        }
        
        if let imageData: Array<JSON> = jsonData["images"].arrayValue {
            
            for item in imageData {
        
                self.image = LDImage(jsonData: item)
            }
        } else {
            return nil
        }
        
    }
    
}
