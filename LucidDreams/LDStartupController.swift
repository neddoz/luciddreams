//
//  LDStartupController.swift
//  LucidDreams
//
//  Created by Pablo Epíscopo on 7/11/16.
//
//

import UIKit
import CocoaLumberjack

class LDStartupController: NSObject {
    
    class func kickoffWithOptions(options: [NSObject : AnyObject]?) {
        
        setenv("XcodeColors", "YES", 0);
        
        DDLog.addLogger(DDTTYLogger.sharedInstance())
        DDLog.addLogger(DDASLLogger.sharedInstance())
        
        let fileLogger: DDFileLogger                      = DDFileLogger()
        fileLogger.rollingFrequency                       = 60 * 60 * 24
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        
        DDLog.addLogger(fileLogger)
        
        DDTTYLogger.sharedInstance().colorsEnabled = true
        
        let errorColor   = UIColor(red:0.93, green:0.4,  blue:0.32, alpha:1.0);
        let debugColor   = UIColor(red:0.78, green:0.8,  blue:0.8,  alpha:1.0);
        let warningColor = UIColor(red:1,    green:0.71, blue:0.31, alpha:1.0);
        let infoColor    = UIColor(red:0.27, green:0.65, blue:0.78, alpha:1.0);
        let verboseColor = UIColor(red:0.75, green:0.56, blue:0.74, alpha:1.0);
        
        DDTTYLogger.sharedInstance().setForegroundColor(debugColor,
                                                        backgroundColor: nil,
                                                        forFlag: .Debug)
        
        DDTTYLogger.sharedInstance().setForegroundColor(errorColor,
                                                        backgroundColor: nil,
                                                        forFlag: .Error)
        
        DDTTYLogger.sharedInstance().setForegroundColor(warningColor,
                                                        backgroundColor: nil,
                                                        forFlag: .Warning)
        
        DDTTYLogger.sharedInstance().setForegroundColor(infoColor,
                                                        backgroundColor: nil,
                                                        forFlag: .Info)
        
        DDTTYLogger.sharedInstance().setForegroundColor(verboseColor,
                                                        backgroundColor: nil,
                                                        forFlag: .Verbose)
        
        #if DEBUG
            DDLogVerbose("Verbose");
            DDLogDebug("Debug");
            DDLogInfo("Info");
            DDLogWarn("Warn");
            DDLogError("Error");
        #endif
        
    }
    
}
