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
    
    @IBOutlet weak var courses: UITextView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courses.userInteractionEnabled = true
        courses.editable = false
        
        
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
                   
//                   self.teacherName.text = self.teacherInfo["teacher"]
//                   self.courses.text = self.teacherInfo["courses"]
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
