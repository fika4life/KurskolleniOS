//
//  TeacherViewController.swift
//  Kurskollen
//
//  Created by Fiona on 25/05/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TeacherViewController: UIViewController {

    
    var teacherId : Int?
    
    var teacherInfo : JSON? = nil
    
    @IBOutlet weak var teacherName: UILabel!
    
   
   
    @IBOutlet weak var courses: UILabel!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courses.numberOfLines = 0
        
        
        let parameters = ["teacherid" : teacherId!]
      
        
        Alamofire.request(.GET, globalConstants.URL + "get-teacher-info", parameters: parameters)
            .validate()
            .responseJSON{(_, _, data, error) in
                
                self.view.endEditing(true)
                if(error != nil){
                    Util.showPopup("Communication error", popupText: "Teachers not gotten", viewController: self)
                }
                else{
                   
                  
                    self.teacherInfo = JSON(data!)
                   println(self.teacherInfo)
                   self.teacherName.text = self.teacherInfo!["name"].string
                   
//                   for course in self.teacherInfo!["courses"]{
//                        self.courses.text += course["name"].stringValue
//                   }
                    
                    var courseText = ""
                    for (index: String, course:JSON) in self.teacherInfo!["courses"]{
                        courseText += course["name"].stringValue + "\n"
                    }
                    self.courses.text  = courseText
                 
//                    self.courses.text = " Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
                }
                
                
        }


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
