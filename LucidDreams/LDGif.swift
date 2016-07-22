//
//  LDGif.swift
//  LucidDreams
//
//  Created by Pablo on 7/16/16.
//
//

import Mapper

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
    //    let trendingDatetime: NSDate
    let image:            LDImage
    
    init(map: Mapper) throws {
        
        let imageMapper = Mapper(JSON: map.optionalFrom("images.fixed_height")!)
        
        try gifId = map.from("id")
        try slug  = map.from("slug")
        try image = LDImage(map: imageMapper)
        
    }
    
}