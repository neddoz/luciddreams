//
//  LDGiphyAPI.swift
//  LucidDreams
//
//  Created by Pablo Epíscopo on 7/11/16.
//
//

import Foundation
import Moya

public  let kLDLimit = 30

private let kLDToken = "dc6zaTOxFJmzC"

public enum Giphy {
    
    case Trend
    case Search(String?, Int)
}

extension Giphy: TargetType {
    
    public var baseURL: NSURL { return NSURL(string: LDConstants.Endpoint.kLDBaseURL)! }
    
    public var path: String {
        
        switch self {
            
        case .Trend:
            return "/gifs/trending"
            
        case .Search(_, _):
            return "gifs/search"
        }
        
    }
    
    public var method: Moya.Method {
        
        switch self {
            
        case .Trend:
            return .GET
            
        case .Search(_, _):
            return .GET
        }
        
    }
    
    public var parameters: [String: AnyObject]? {
        
        switch self {
            
        case .Trend:
            return ["api_key": kLDToken, "limit": kLDLimit]
        
            
        case .Search(let query, let offset):
            return ["api_key": kLDToken, "q": query ?? "", "rating": "pg", "offset": offset]
        }
        
    }
    
    public var sampleData: NSData {
        
        switch self {
            
        case .Trend:
            return "}".dataUsingEncoding(NSUTF8StringEncoding)!
            
        case .Search(_, _):
            return "".dataUsingEncoding(NSUTF8StringEncoding)!
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
