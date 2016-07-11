//
//  LDSearchNavigationController.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit
import Foundation

class LDSearchNavigationController: LDNavigationController, UITextFieldDelegate {
    
    let searchBar = LDSearchBar()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        let margin: CGFloat = 45.0
        
        self.searchBar.frame    = CGRectMake(margin, -2.0, self.navigationBar.width - (margin * 2), 25.0)
        self.searchBar.center   = self.navigationBar.center
        self.searchBar.delegate = self
        
        self.navigationBar.topItem?.titleView = self.searchBar
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if (string as NSString).isEqualToString("\n") {
            
            return true
        }
        
        textField.text = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string.uppercaseString)
        
        return false
    }
    
}
