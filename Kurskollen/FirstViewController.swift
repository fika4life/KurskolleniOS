//
//  FirstViewController.swift
//  Kurskollen
//
//  Created by Fiona on 30/03/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController {
    
    
    


    @IBOutlet weak var emailField: UITextField!

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var confirmPasswordField: UITextField!

    @IBOutlet weak var alert: UILabel!
    
   
   
    
    @IBAction func toLogin(sender: AnyObject) {
        //let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        println("test")
        
        //let secondViewController = storyboard.instantiateViewControllerWithIdentifier("SecondViewController") as UIViewController
        let secondViewController = SecondViewController(nibName: "SecondViewController", bundle: nil)
        
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    @IBAction func createAccount(sender: AnyObject) {
        
        var email = emailField.text
        var username = usernameField.text
        var password = passwordField.text
        var confirmPsw = confirmPasswordField.text
        let red = UIColor.redColor().CGColor
        
        if(password == confirmPsw){
            self.alert.text = ""
            if (!isValidEmail(email)){
                emailField.layer.borderColor = red
                emailField.layer.borderWidth = 1.5
                emailField.layer.cornerRadius = 5
                alert.text = "Felformaterad epost"
            }
            else if (!isValidPassword(password)){
                passwordField.layer.borderColor = red
                passwordField.layer.borderWidth = 1.5
                passwordField.layer.cornerRadius = 5
                alert.text = "Lösenordet måste innehålla minst 8 tecken och 1 siffra"
            }else{
                Alamofire.request(.POST, globalConstants.URL + "add-account", parameters: ["email" : email, "password": password, "name": username])
                    .validate()
                    .responseString{(request, response, data, error) in
                        println(error)
                        self.view.endEditing(true)
                        
                        //create alert
                        let alert: UIAlertController = UIAlertController(title: "Alert", message: "Ett bekräftelsemail har skickats till den angivna epostadressen", preferredStyle: .Alert)
                        
                        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
                            self.performSegueWithIdentifier("segueID", sender: self)

                        }
                        
                        alert.addAction(okAction)
                        //Present the AlertController
                        self.presentViewController(alert, animated: true, completion: nil)
                        //if username exists
                        if (error != nil){
                            if (data == "user-or-email-exists"){
                        
                                self.alert.text = "Användarnamn och/eller epost finns redan"
                            }
                            println(data)
                            self.emailField.layer.borderColor = red
                            self.emailField.layer.borderWidth = 1.5
                            self.emailField.layer.cornerRadius = 5
                            self.usernameField.layer.borderColor = red
                            self.usernameField.layer.borderWidth = 1.5
                            self.usernameField.layer.cornerRadius = 5
                            self.view.endEditing(true)
                        }
                    }
            }
            
        }
        else{
            alert.text = "Lösenorden matchar inte"
            passwordField.layer.borderColor = red
            passwordField.layer.borderWidth = 1.5
            passwordField.layer.cornerRadius = 5
            confirmPasswordField.layer.borderColor = red
            confirmPasswordField.layer.borderWidth = 1.5
            confirmPasswordField.layer.cornerRadius = 5
        }
        
     
       
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        if let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx) {
            return emailTest.evaluateWithObject(email)
        }
        return false
    }
    
    func isValidPassword(psw: String) -> Bool {
        let emailRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        if let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx) {
            return emailTest.evaluateWithObject(psw)
        }
        return false
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

