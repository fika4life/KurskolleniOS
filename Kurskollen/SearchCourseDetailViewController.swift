//
//  SearchCourseDetailViewController.swift
//  Kurskollen
//
//  Created by Fiona on 20/04/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit

class SearchCourseDetailViewController: UIViewController, UITableViewDataSource {
    
    
   
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var credits: UILabel!
    @IBOutlet weak var online: UILabel!
    @IBOutlet weak var teacher: UIButton!
    
    @IBOutlet weak var reviewTable: UITableView!
    
    self.courseData:JSON?
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courseData!["reviews"].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("reviewTableCell", forIndexPath: indexPath) as ReviewListTableCell
        
        
        
        let review :JSON = self.coursesData!["reviews"][indexPath.row]
        cell.timeText.text  = review["user"].string
        cell.reviewText.text = review["text"].string
        return cell
    }

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
