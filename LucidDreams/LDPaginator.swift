//
//  LDPaginator.swift
//  LucidDreams
//
//  Created by Pablo Epíscopo on 7/13/16.
//
//

import Foundation
import SwiftyJSON
import Moya_SwiftyJSONMapper

class LDPaginator: ALSwiftyJSONAble {
    
    var count:  NSNumber
    var offset: NSNumber
    
    required init?(jsonData:JSON) {
        
        if let count = jsonData["count"].number {
            
            self.count = count
        } else {
            return nil
        }

        if let offset = jsonData["offset"].number {
            
            self.offset = offset
        } else {
            return nil
        }

    }
    
}