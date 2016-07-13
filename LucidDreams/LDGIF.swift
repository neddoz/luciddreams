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
    var trendingDatetime: NSDate?
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
        
        if let trendingDate = jsonData["trending_datetime"].string {
            
            let dateFormatter        = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            self.trendingDatetime = NSDate() // dateFormatter.dateFromString(trendingDate)!
        } else {
            return nil
        }

        if let imageData = jsonData["images"].dictionary {
            
            if let data: AnyObject = imageData["fixed_height_downsampled"]!.rawValue {
                
                self.image = LDImage(jsonData: JSON.init(rawValue: data)!)
            }
        } else {
            return nil
        }
        
    }
    
}
