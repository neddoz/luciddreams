//
//  LDNavigationBar.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit

class LDNavigationBar: UINavigationBar {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        self.barTintColor = UIColor.navigationBarColor()
        self.translucent  = false;
        
    }
    
    @IBInspectable var inspectableTintColor: UIColor? {
        
        didSet {
            
            self.tintColor = inspectableTintColor
            
        }
        
    }

}
