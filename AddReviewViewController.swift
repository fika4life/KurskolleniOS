//
//  AddReviewViewController.swift
//  Kurskollen
//
//  Created by Fiona on 24/04/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddReviewViewController: UIViewController {
    
    var courseId : Int?
    
    @IBOutlet weak var reviewTeacher: UITextField!

    @IBOutlet weak var reviewText: UITextField!
    
    @IBOutlet weak var rating: UITextField!
   
    @IBAction func Done(sender: AnyObject) {
        let text = reviewText.text
        let theRating = rating.text
        let teacher = reviewTeacher.text
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let email = userDefaults.stringForKey(globalConstants.emailMemoryKey)
        let loginSession = userDefaults.stringForKey(globalConstants.loginSessionMemoryKey)
        
        let parameters = ["email" : email, "loginsession" : loginSession, "rating" : theRating, "courseid" : self.courseId!, "teacherid" : teacher, "text" : text]
        
        Alamofire.request(.POST, globalConstants.URL + "create-review", parameters: parameters)
            .validate()
            .responseJSON{(request, response, data, error) in
                self.view.endEditing(true)
                if(error != nil){
                    var alert = UIAlertController(title: "Communication error", message: "Could not communicate with server", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else{
                    
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
