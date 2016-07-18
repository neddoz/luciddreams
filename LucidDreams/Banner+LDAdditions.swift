//
//  Banner+LDAdditions.swift
//  LucidDreams
//
//  Created by Pablo Epíscopo on 7/15/16.
//
//

import Foundation
import BRYXBanner

extension Banner {
    
    static func showErrorBanner() {
        
        showErrorBanner("Ouch!", subtitle: "Something went wrong.")
    }
    
    static func showErrorBanner(title: String, subtitle: String) {
        
        let banner = Banner(title:           title,
                            subtitle:        subtitle,
                            image:           UIImage(named: "error-banner-icon"),
                            backgroundColor: UIColor(red:0.95, green:0.33, blue:0.34, alpha:1.00))
        
        banner.dismissesOnTap = true
        
        banner.show(duration: 3.0)
    }
    
}
