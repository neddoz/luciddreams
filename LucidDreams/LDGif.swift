//
//  LDGif.swift
//  LucidDreams
//
//  Created by Pablo on 7/16/16.
//
//

import Mapper
import Timepiece

struct LDImage: Mappable {
    
    let url:    String
    let width:  String
    let height: String
    
    init(map: Mapper) throws {
            
        try url    = map.from("url")
        try width  = map.from("width")
        try height = map.from("height")
        
    }
    
}

struct LDGif: Mappable {
    
    let gifId:            String
    let slug:             String
    let trendingDatetime: String
    let image:            LDImage
    
    init(map: Mapper) throws {
        
        let imageMapper = Mapper(JSON: map.optionalFrom("images.fixed_height")!)
        
        try gifId            = map.from("id")
        try slug             = map.from("slug")
        try trendingDatetime = map.from("trending_datetime") ?? ""
        try image            = LDImage(map: imageMapper)
        
    }
    
}

extension LDGif {
    
    func isTrending() -> Bool {
        
        let trendingDate    = self.trendingDatetime.dateFromFormat("yyyy-MM-dd HH:mm:ss")
        let beginningOfTime = NSDate.date(year:   1970,
                                          month:  01,
                                          day:    01,
                                          hour:   00,
                                          minute: 00,
                                          second: 00)
        
        if beginningOfTime != trendingDate {
        
            return true
            
        }
        
        return false
        
    }
    
}