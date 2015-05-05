//
//  AddCourseViewController.swift
//  Kurskollen
//
//  Created by Fiona on 24/04/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit
import Alamofire

class AddCourseViewController: UIViewController {
    
    @IBOutlet weak var school: UITextField!
    
    @IBOutlet weak var courseName: UITextField!

    @IBOutlet weak var courseDesc: UITextField!
    
    
    @IBOutlet weak var credits: UITextField!
    
    @IBOutlet weak var online: UISwitch!

    @IBOutlet weak var teacher: UITextField!
    
    @IBAction func Done(sender: AnyObject) {
        let courseNameText = courseName.text
        let courseDescText = courseDesc.text
        let creditsText = credits.text
        let onlineValue = online.on
        let onlineString = onlineValue ? "1" : "0"
    
        //Should be changed:
        let courseCode = "DD1234"
        let schoolId = 1
        let teacherId = 1
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let email = userDefaults.stringForKey(globalConstants.emailMemoryKey)
        let loginSession = userDefaults.stringForKey(globalConstants.loginSessionMemoryKey)
        
        let parameters : [String: String] = ["email": email!, "loginsession": loginSession!, "coursecode": courseCode, "name": courseNameText, "credits": creditsText,"online": onlineString, "schoolid": String(schoolId)]
        
        Alamofire.request(.POST, globalConstants.URL + "add-course", parameters: parameters)
            .validate()
            .response{(_, _, _, error) in
                self.view.endEditing(true)
                if(error != nil){
                    println(parameters)
                    var alert = UIAlertController(title: "Kommunikationsfel", message: "Kunde inte kommunicera med servern", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else{
                    var alert = UIAlertController(title: "Kursen tillagd", message: "Kursen lades till", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.online.on  = false
        
        
        

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
