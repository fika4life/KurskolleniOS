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

class AddReviewViewController: UIViewController, UITableViewDataSource {
    
    var reviewData:JSON?
    
    var courseId : Int?
    
    @IBOutlet weak var reviewTeacher: UITextField!

    @IBOutlet weak var reviewText: UITextField!
    
    @IBOutlet weak var rating: UITextField!
    
    var suggestions : JSON?
    
    var autoCompleteTableView : UITableView?
    
    
    @IBAction func onType(sender: AnyObject) {
        let teacherStarting = self.reviewTeacher.text
        if(teacherStarting != ""){
            self.getsuggestionJSON(teacherStarting)
        }
        else{
            self.autoCompleteTableView!.hidden = true
        }
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
        
        self.autoCompleteTableView = UITableView(frame: CGRectMake(0, 80, 320, 120),style:UITableViewStyle.Plain)
        autoCompleteTableView!.dataSource = self
        autoCompleteTableView!.scrollEnabled = true
        autoCompleteTableView!.hidden = true
        
        self.view.insertSubview(autoCompleteTableView!, belowSubview: reviewTeacher)

        // Do any additional setup after loading the view.
        self.autoCompleteTableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.suggestions == nil){
            return 0
        }
        return self.suggestions!.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.autoCompleteTableView!.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        let teacherJsonObject = suggestions![indexPath.row]
        
        cell.textLabel?.text = teacherJsonObject["name"].string
        
        return cell
    }
    
    func getsuggestionJSON(teacherStarting : String){
        let parameters : [String: String] = ["teacherStarting" : teacherStarting]
        Alamofire.request(.GET, globalConstants.URL+"get-teacher-by-starting-string", parameters: parameters)
            .validate()
            .responseJSON{(request, response, data, error) in
                self.view.endEditing(true)
                if(error == nil){
                    self.suggestions = JSON(data!)
                    println(self.suggestions)
                    if(self.suggestions!.count>0){
                        self.autoCompleteTableView!.reloadData()
                        self.autoCompleteTableView!.hidden = false
                    }
                    else{
                        self.autoCompleteTableView!.hidden = true
                    }
                }
                else{
                    self.autoCompleteTableView!.hidden = false
                }
            }
        
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
