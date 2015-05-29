//
//  SearchCourseDetailViewController.swift
//  Kurskollen
//
//  Created by Fiona on 20/04/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit
import SwiftyJSON
import ActionSheetPicker_3_0
import Alamofire

class SearchCourseDetailViewController: UIViewController, UITableViewDataSource {
    
    
    
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var credits: UILabel!
   
    @IBOutlet weak var coursecode: UILabel!
    @IBOutlet weak var online: UILabel!
  
    
    @IBOutlet weak var teacherField: UIButton!
    
    @IBOutlet weak var rating: UILabel!
    
    
    @IBOutlet weak var reviewTable: UITableView!
    
    var courseData:JSON?

    var reviewsToDisplay : JSON = []
    
    var teacherName : String?
    
    @IBAction func addCoursetoFavs(sender: AnyObject) {
        let (email, loginSession) = Util.getLoginCredentials()
        let courseId = courseData!["id"].intValue
    
        
        let parameters = ["email" : email, "loginsession" : loginSession, "courseid" : String(courseId)]
        println(parameters)
        Alamofire.request(.GET, globalConstants.URL+"add-bookmark", parameters: parameters)
            .validate()
            .response{(_, _, _, error) in
                if(error != nil){
                    //println(self.suggestions)
                     Util.showPopup("Uppdaterat", popupText: "Kursen har lagts till som favorit", viewController: self)
                }
                else{
                  
                     Util.showPopup("Error", popupText: "Kunde inte kommunicera med servern", viewController: self)
                }
        }

    }
    @IBAction func chooseTeacher(sender: AnyObject) {
       
        let reviews = courseData!["reviews"]
        var teachers = [String]()
        for (index: String, review: JSON) in reviews {
            if (!contains(teachers, review["teacher"].stringValue)){
                teachers.append(review["teacher"].stringValue)
            }
        }
    
    
        ActionSheetStringPicker.showPickerWithTitle("Välj teacher", rows: teachers, initialSelection: 1,
            doneBlock: {
                picker, value, index in
                self.teacherName = String(teachers[value])

                self.teacherField.setTitle(String(teachers[value]),  forState: UIControlState.Normal)
                let reviews = courseData!["reviews"]


                self.reviewsToDisplay = []
                for (index: String, review: JSON) in reviews {
                    if(review["teacher"].stringValue == self.teacherName){
                        self.reviewsToDisplay[index.toInt()] = review
                    }
                }
                self.reviewTable.reloadData()
                return
            },cancelBlock: { ActionStringCancelBlock in return }, origin:sender )
        
    }

   
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        println(self.courseData!["reviews"])
        return self.reviewsToDisplay.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("reviewTableCell", forIndexPath: indexPath) as ReviewListTableCell
        
        
        
        
        
        let review :JSON = self.reviewsToDisplay[indexPath.row]
        let timeStamp = review["time"].doubleValue
        
        
        let dateString = Util.formatTimeSwedishStyle(timeStamp)
        
        cell.timeField.text = dateString
        cell.reviewerNameText.text = review["user"].string
        cell.reviewText.text = review["text"].string
        return cell
    }

    @IBAction func writeReview(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject!) {
//        println("segue:" + segue!.identifier!)
        if (segue!.identifier == "addReview") {
            var svc = segue!.destinationViewController as AddReviewViewController
            svc.courseId = self.courseData!["id"].int
        }else if (segue!.identifier == "toTeacher"){
            
                let teacherId = 1
                var svc = segue!.destinationViewController as TeacherViewController
                svc.teacherId = teacherId
            

        }
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        var nib = UINib(nibName: "ReviewListTableCell", bundle: nil)
        reviewTable.registerNib(nib, forCellReuseIdentifier: "reviewTableCell")
        self.course.text = self.courseData!["name"].string
        self.school.text = self.courseData!["school"].string;
        self.credits.text = String(format: "%.1f", self.courseData!["credits"].doubleValue)
        self.online.text = self.courseData!["online"].boolValue ? "Distans" : "Ortsbunden"
        
        if let meanrating = self.courseData!["meanRating"].double{
            self.rating.text = "Betyg: " + String(format: "%.2f",meanrating)

        }else{
            self.rating.text =  nil
        }
        
        if let courseCode = self.courseData!["courseCode"].string{
            self.coursecode.text = courseCode
            
        }else{
            self.coursecode.text =  nil
        }

        self.reviewsToDisplay = self.courseData!["reviews"]
        self.reviewTable.reloadData()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
