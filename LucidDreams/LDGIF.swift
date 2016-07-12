//
//  LDGIF.swift
//  LucidDreams
//
//  Created by Pablo Epíscopo on 7/12/16.
//
//

import UIKit
import SwiftyJSON
import Moya_SwiftyJSONMapper

class LDGIF: ALSwiftyJSONAble {
    
    var gifId:            String
    var slug:             String
    var trendingDatetime: NSDate
    var gifURL:           String

    required init?(jsonData: JSON) {
        
        let json = jsonData["data"].array![0]
        
        if let gifId = json["id"].string {
            
            self.gifId = gifId
            
        } else {
        
            print(json["id"])
            
            return nil
        }
        
        if let slug = json["slug"].string {
            
            self.slug = slug
            
        } else {
            
            print(json["slug"])
            
            return nil
        }
        
        if json["trending_datetime"].string != nil {
            
            self.trendingDatetime = NSDate()
            
        } else {
            
            print(json["trending_datetime"])
            
            return nil
        }
        
        if let gifURL = json["images"]["fixed_width_downsampled"]["url"].string {
            
            self.gifURL = gifURL
            
        } else {
    
            print(json["images"]["fixed_width_downsampled"]["url"])
            
            return nil
        }
        
    }
    
}
