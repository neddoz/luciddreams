//
//  ViewController.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit
import SwiftyJSON
import CocoaLumberjack

class LDHomeViewController: LDViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GiphyProvider.request(.Trend, completion: { (result) in
            
            switch result {
            case let .Success(response):
                do {
                    
                    let getResponseObject = try response.mapArray(LDGIF)
                    print(getResponseObject)
                } catch {
                    
                    print(error)
                }
            case let .Failure(error):
                
                print(error)
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
}

