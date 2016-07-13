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
    
    var GIFs:       Array<LDGIF> = []
    var pagination: LDPaginator?
    
    required init?(jsonData:JSON) {
        
        if let data = jsonData["data"].array {
            
            for gifData in data {
                
                self.GIFs.append(LDGIF(jsonData: gifData)!)
            }
        } else {
            return nil
        }
        
        
        if let paginationData: AnyObject = jsonData["pagination"].rawValue {
            
            self.pagination = LDPaginator(jsonData: JSON.init(rawValue: paginationData)!)
        } else {
            return nil
        }
        
    }
    
}