//
//  CreatePopup.swift
//  Kurskollen
//
//  Created by Fredrik Wallén on 05/05/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit


class Util{
    
    class private let dateFormat = "dd-MM-yyyy HH:mm"
    

    class func showPopup(popupTitle : String, popupText : String, viewController : UIViewController){
        var alert = UIAlertController(title: popupTitle, message: popupText, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func getLoginCredentials() -> (email: String!, loginSession: String!){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let email = userDefaults.stringForKey(globalConstants.emailMemoryKey)
        let loginSession = userDefaults.stringForKey(globalConstants.loginSessionMemoryKey)
        return (email, loginSession)
    }
    
    class func formatTimeSwedishStyle(timestamp : Double) ->String{
        let date = NSDate(timeIntervalSince1970: timestamp)
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.stringFromDate(date)
    }
}