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
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func getLoginCredentials() -> (email: String!, loginSession: String!){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let email = userDefaults.stringForKey(globalConstants.emailMemoryKey)
        let loginSession = userDefaults.stringForKey(globalConstants.loginSessionMemoryKey)
        return (email, loginSession)
    }
}