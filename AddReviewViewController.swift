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
   
    @IBAction func onType(sender: AnyObject) {
        
    }
    @IBAction func Done(sender: AnyObject) {
        let text = reviewText.text
        let theRating = rating.text
        let teacher = reviewTeacher.text
        
        let (email, loginSession) = Util.getLoginCredentials()
        
        let parameters = ["email" : email, "loginsession" : loginSession,"rating" : theRating,"courseid" : String(self.courseId!), "teacherid" : teacher, "text" : text]
        
        Alamofire.request(.POST, globalConstants.URL + "create-review", parameters: parameters)
            .validate()
            .response{(_, _, _, error) in
                self.view.endEditing(true)
                if(error != nil){
                    Util.showPopup("Communication error", popupText: "Could not communicate with server", viewController: self)
                }
                else{
                    Util.showPopup("Added", popupText: "The review was successfully added", viewController: self)
                }
        }
    }
    
    override func viewDidLoad() {
        println("AddReview: courseId="+String(courseId!))
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
