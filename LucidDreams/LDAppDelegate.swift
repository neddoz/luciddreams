//
//  AppDelegate.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit

@UIApplicationMain

class LDAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        LDStartupController.kickoffWithOptions(launchOptions);
        
        return true
        
    }

}

