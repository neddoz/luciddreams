//
//  LDGiphyAPI.swift
//  LucidDreams
//
//  Created by Pablo Epíscopo on 7/11/16.
//
//

import Foundation
import Moya
import SwiftyJSON
import Moya_SwiftyJSONMapper

let GiphyProvider = MoyaProvider<Giphy>()

private let token = "dc6zaTOxFJmzC"

public enum Giphy {
    
    case Trend
}

extension Giphy: TargetType {
    
    public var baseURL: NSURL { return NSURL(string: LDConstants.Endpoint.kLDBaseURL)! }
    
    public var path: String {
        
        switch self {
            
        case .Trend:
            return "/gifs/trending"
        }
    }
    
    public var method: Moya.Method {
        
        switch self {
            
        case .Trend:
            return .GET
        }
    }
    
    public var parameters: [String: AnyObject]? {
        
        switch self {
            
        case .Trend:
            return ["api_key": token]
        }
    }
    
    public var sampleData: NSData {
        
        switch self {
            
        case .Trend:
            return "{\"data\":{\"id\":\"your_new_gif_id\"},\"meta\":{\"status\":200,\"msg\":\"OK\"}}".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
    
}

// MARK: - Helper Methods

private extension String {
    
    var URLEscapedString: String {
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
    
    var UTF8EncodedData: NSData {
        
        return self.dataUsingEncoding(NSUTF8StringEncoding)!
    }
}
