//
//  LDGiphyAPI.swift
//  LucidDreams
//
//  Created by Pablo Epíscopo on 7/11/16.
//
//

import Foundation
import Moya

private let token = "dc6zaTOxFJmzC"

public enum Giphy {
    
    case Trend
    case Random
    case Search(String, Int)
}

extension Giphy: TargetType {
    
    public var baseURL: NSURL { return NSURL(string: LDConstants.Endpoint.kLDBaseURL)! }
    
    public var path: String {
        
        switch self {
            
        case .Trend:
            return "/gifs/trending"
            
        case .Random:
            return "gifs/random"
            
        case .Search(_, _):
            return "gifs/search"
        }
    }
    
    public var method: Moya.Method {
        
        switch self {
            
        case .Trend:
            return .GET
            
        case .Random:
            return .GET
            
        case .Search(_, _):
            return .GET
        }
    }
    
    public var parameters: [String: AnyObject]? {
        
        switch self {
            
        case .Trend:
            return ["api_key": token, "limit": 30]
            
        case .Random:
            return ["api_key": token, "rating": "pg"]
            
        case .Search(let query, let offset):
            return ["api_key": token, "q": query, "rating": "pg", "offset": offset]
        }
    }
    
    public var sampleData: NSData {
        
        switch self {
            
        case .Trend:
            return "}".dataUsingEncoding(NSUTF8StringEncoding)!
            
        case .Random:
            return "".dataUsingEncoding(NSUTF8StringEncoding)!
            
        case .Search(_, _):
            return "".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }

//    public var multipartBody: [MultipartFormData]? {
//        
//        switch self {
//            
//        case .Trend:
//            return nil
//            
//        case .Random:
//            return nil
//            
//        case .Search(_, _):
//            return nil
//        }
//    }
    
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
