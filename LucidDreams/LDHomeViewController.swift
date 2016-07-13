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
                   
                    let response = try response.mapObject(LDResponse)
                    
                } catch {
                    guard let error = error as? CustomStringConvertible else {
                        break
                    }
                    
                    print(error.description)
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

