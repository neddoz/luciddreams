//
//  LDConstants.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import Foundation

struct LDConstants {
    
    struct Endpoint {

        static let kLDApiProtocol = "http";
        static let kLDApiDomain   = "giphy.com";
        static let kLDApiVersion  = "v1";
        static let kLDApiPrefix   = "api";
        
        static let kLDBaseURL     = "\(kLDApiProtocol)://\(kLDApiPrefix).\(kLDApiDomain)/\(kLDApiVersion)/gifs"
    }
    
    struct Fonts {
        
        static let kPrimaryFontBlack = "SFUIDisplay-Black"
    }
    
}