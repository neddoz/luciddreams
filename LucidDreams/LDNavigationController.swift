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
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        let separatorHeight: CGFloat = 2.0
        
        separator.frame = CGRectMake(0.0, self.navigationBar.height - separatorHeight, self.navigationBar.width, separatorHeight)
        
        self.navigationBar.addSubview(separator)
        
        let logoImage         = UIImageView(image: UIImage(named: "title-logo"))
        logoImage.contentMode = .ScaleAspectFit
        
        self.navigationBar.topItem?.titleView = logoImage
        
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
