//
//  SettingsViewController.swift
//  Kurskollen
//
//  Created by Fiona on 24/04/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class SettingsViewController: UIViewController {

    var parameters = [String: String]()

    @IBOutlet weak var editedUsername: UITextField!
  
    @IBOutlet weak var editedPassword: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBAction func updateSettings(sender: AnyObject) {
        
        let username = editedUsername.text
        let password = editedPassword.text
        let confirmpw = confirmPassword.text
        
        let (email, loginSession) = Util.getLoginCredentials()
        
        
        self.parameters["email"] = email
        self.parameters["loginsession"] = loginSession
        
        if(username != ""){
            self.parameters["newName"] = username
        }
       
        if(password != "" && confirmpw != ""  && password == confirmpw){
            self.parameters["newPassword"] = confirmpw
        }else if(password != "" && confirmpw != ""  && password != confirmpw){
            var alert = UIAlertController(title: "Lösenord matchas inte", message: "Försök igen", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else if(password == "" && confirmpw != "" || password != "" && confirmpw == "" ){
            var alert = UIAlertController(title: "Fel", message: "Lösenord ska skrivas 2 gångar", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
       
        println(parameters)
        
        Alamofire.request(.POST, globalConstants.URL + "change-user-setting", parameters: self.parameters)
            .validate()
            .responseJSON{(request, response, data, error) in
               
                if(error != nil){
                    var alert = UIAlertController(title: "Communication error", message: "Could not communicate with server", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else{
                    var alert = UIAlertController(title: "Inställningar uppdaterade", message: "Dina uppgifter har uppdaterats", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
        }
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
