//
//  LDSearchBar.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit

class LDSearchBar: UITextField {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        
        self.backgroundColor           = UIColor.clearColor()
        self.contentVerticalAlignment  = .Center;
        self.textAlignment             = .Center;
        self.tintColor                 = UIColor.yellowGiphyColor()
        self.font                      = UIFont(name: LDConstants.Fonts.kPrimaryFontBlack, size:16.0)
        self.minimumFontSize           = 13
        self.adjustsFontSizeToFitWidth = true
        self.textColor                 = UIColor.whiteColor()
        self.keyboardAppearance        = .Dark
        self.returnKeyType             = .Search
    }
    
    override func drawRect(rect: CGRect) {
        
        super.drawTextInRect(rect)
        
        self.becomeFirstResponder()
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        
        if action == #selector(NSObject.copy(_:)) || action == #selector(NSObject.paste(_:)) {
            
            return false;
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
    
}
