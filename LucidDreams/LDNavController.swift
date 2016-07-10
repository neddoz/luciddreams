//
//  LDNavController.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit

class LDNavController: UINavigationController {
    
    var navBarHairlineImageView: UIImageView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        self.setValue(LDNavigationBar(), forKey: "navigationBar")
        
        self.navBarHairlineImageView = findHairlineImageViewUnder(self.navigationBar);
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
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navBarHairlineImageView.hidden = true;
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.navBarHairlineImageView.hidden = false;
    }
    
    func findHairlineImageViewUnder(view: UIView) -> UIImageView? {
        
        if view.isKindOfClass(UIImageView) && view.height <= 1.0 {
            
            return view as? UIImageView
            
        }
        
        for subview in view.subviews {
            
            let imageView: UIImageView? = findHairlineImageViewUnder(subview);
            
            if (imageView != nil) {
                
                return imageView!;
            }
        }
        
        return nil;
    }

}
