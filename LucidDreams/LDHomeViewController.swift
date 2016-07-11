//
//  ViewController.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit

class LDHomeViewController: LDViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GiphyProvider.request(.Trend, completion: { (result) in
            
            var message = "Unable to fetch from Giphy"
            
            switch result {
                
            case let .Success(response):
                do {
                    
                    let json: NSArray? = try response.mapJSON() as? NSArray
                    
                    if let json = json {
                    
                        print(json)
                        
                    }
                } catch {
                    
                    
                }
                
            case let .Failure(error):
                guard let error = error as? CustomStringConvertible else {
                    
                    break
                }
                
                message = error.description
                print(message)
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

}

