//
//  LDViewController.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit

class LDViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        self.refreshControl           = UIRefreshControl()
        self.refreshControl.tintColor = UIColor.yellowGiphyColor()
        
        self.refreshControl.addTarget(self,
                                      action: #selector(refreshAction),
                                      forControlEvents: .ValueChanged)
        
        tableView.addSubview(refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
    }
    
    func refreshAction() {
        
        // Override me <--
    }
    
}