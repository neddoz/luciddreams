//
//  UIView+LDAdditions.swift
//  LucidDreams
//
//  Created by Pablo Epíscopo on 7/11/16.
//
//

import UIKit
import Foundation

extension UIView {
    
    func loadViewFromNib() -> UIView {
        
        let bundle  = NSBundle(forClass: self.dynamicType)
        let nib     = UINib(nibName: String(self.dynamicType), bundle: bundle)
        let nibView = nib.instantiateWithOwner(self, options: nil).first as! UIView
        
        return nibView
    }
    
}
