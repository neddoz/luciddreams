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
    
    let searchTextField = LDSearchTextField()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        let margin: CGFloat = 45.0
        
        self.searchTextField.frame       = CGRectMake(margin, -2.0, self.navigationBar.width - (margin * 2), 25.0)
        self.searchTextField.center      = self.navigationBar.center
        
        self.navigationBar.topItem?.titleView = self.searchTextField
    }
    
}
