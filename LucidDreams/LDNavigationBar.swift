//
//  LDNavigationBar.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit

class LDNavigationBar: UINavigationBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tintColor   = UIColor.navigationBarColor()
        self.translucent = false;
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

}
