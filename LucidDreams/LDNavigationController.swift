//
//  LDNavController.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit

class LDNavigationController: UINavigationController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        self.setValue(LDNavigationBar(), forKey: "navigationBar")
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        let separatorHeight: CGFloat = 2.0
        
        let separator             = UIView()
        separator.frame           = CGRectMake(0.0, self.navigationBar.height - separatorHeight, self.navigationBar.width, separatorHeight)
        separator.backgroundColor = UIColor.greenGiphyColor()
        
        self.navigationBar.addSubview(separator)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
    }

}
