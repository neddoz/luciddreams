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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search-icon"),
                                                                 style: .Plain,
                                                                 target: self,
                                                                 action: #selector(showSearch))
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showSearch(sender: AnyObject) {
        
        
    }

}

