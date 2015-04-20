//
//  SearchCourseDetailViewController.swift
//  Kurskollen
//
//  Created by Fiona on 20/04/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit

class SearchCourseDetailViewController: UIViewController {
    
    
   
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var credits: UILabel!
    @IBOutlet weak var online: UILabel!
    @IBOutlet weak var teacher: UIButton!
    
    self.courseData:JSON?

    @IBAction func writeReview(sender: AnyObject) {
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        course.text = courseData["name"].string
        school.text = courseData["school"].string;
        credits.text = String(courseData["credits"].int)
        online.text = courseData["online"].boolean ? "Distans" : "Ortsbunden"
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
