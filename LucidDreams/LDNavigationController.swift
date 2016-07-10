//
//  LDNavController.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit

class LDNavigationController: UINavigationController {
    
    let separator = UIView()

    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        self.setValue(LDNavigationBar(), forKey: "navigationBar")
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
//        let titleView = UIImageView(frame: CGRectMake(0.0, 0.0, 35.0, 26.79))
//        titleView.backgroundColor = UIColor.redColor()
//        
//        self.navigationItem.titleView = titleView
        
        let separatorHeight: CGFloat = 2.0
        
        separator.frame = CGRectMake(0.0, self.navigationBar.height - separatorHeight, self.navigationBar.width, separatorHeight)
        
        self.navigationBar.addSubview(separator)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
    }
    
    @IBInspectable var separatorColor: UIColor? {
        
        didSet {
            
            separator.backgroundColor = separatorColor
        }
    }

}
