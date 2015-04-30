//
//  SecondViewController.swift
//  Kurskollen
//
//  Created by Fiona on 30/03/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit
import Alamofire

class SecondViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    
    @IBOutlet weak var alert: UITextView!
    
    @IBAction func login(sender: AnyObject) {
        var email = emailField.text
        var password = passwordField.text
        let red = UIColor.redColor().CGColor
        
        Alamofire.request(.POST, globalConstants.URL + "login", parameters: ["email" : email, "password" : password])
            .validate()
            .responseString{(request, response, data, error) in
                println(error)
                println(data)
                self.view.endEditing(true)
                if (error != nil){
                    if(data == "user-not-activated"){
                        self.alert.text = "Kontot är inte aktiverat. Kolla din epost för aktiveringsmail"
                    }else if(data == "wrong-email-or-password"){
                        self.alert.text = "Fel epost eller lösenord"
                    }
                }else{
                    let userDefaults = NSUserDefaults.standardUserDefaults()
                    userDefaults.setObject(email, forKey: globalConstants.emailMemoryKey)
                    userDefaults.setObject(data, forKey: globalConstants.loginSessionMemoryKey)
                    userDefaults.synchronize()
                    self.performSegueWithIdentifier("toSearch", sender: self)
                }
        }
        //on button click keyboard disappears
        self.passwordField.resignFirstResponder()
        self.emailField.resignFirstResponder()
    }
    
    //hides keyboard if user presses anywhere else on screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

