//
//  CreatePopup.swift
//  Kurskollen
//
//  Created by Fredrik Wallén on 05/05/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit


class Util{
    
    
    

    class func showPopup(popupTitle : String, popupText : String, viewController : UIViewController){
        var alert = UIAlertController(title: popupTitle, message: popupText, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func getLoginCredentials() -> (email: String!, loginSession: String!){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let email = userDefaults.stringForKey(globalConstants.emailMemoryKey)
        let loginSession = userDefaults.stringForKey(globalConstants.loginSessionMemoryKey)
        return (email, loginSession)
    }
    
    class func formatTimeSwedishStyle(timestamp : Double) ->String{
        let dateFormat = "dd-MM-yyyy HH:mm"
        
        let date = NSDate(timeIntervalSince1970: timestamp)
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.stringFromDate(date)
    }

    class func allKeysForValue<K, V : Equatable>(dict: [K : V], val: V) -> [K] {
        return map(filter(dict) { $1 == val }) { $0.0 }
    }


}