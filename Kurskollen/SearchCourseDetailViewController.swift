//
//  SearchCourseDetailViewController.swift
//  Kurskollen
//
//  Created by Fiona on 20/04/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchCourseDetailViewController: UIViewController, UITableViewDataSource {
    
    
    
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var credits: UILabel!
   
    @IBOutlet weak var online: UILabel!
    @IBOutlet weak var teacher: UIButton!
    @IBOutlet weak var reviewTable: UITableView!
    
    var courseData:JSON?
    

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(self.courseData!["reviews"])
        return self.courseData!["reviews"].count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("reviewTableCell", forIndexPath: indexPath) as ReviewListTableCell
        
        
        
        let review :JSON = self.courseData!["reviews"][indexPath.row]
        cell.timeField.text  = String(review["time"].intValue)
        println(review["time"].intValue)
        cell.reviewerNameText.text = review["user"].string
        cell.reviewText.text = review["text"].string
        return cell
    }

    @IBAction func writeReview(sender: AnyObject) {
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        var nib = UINib(nibName: "ReviewListTableCell", bundle: nil)
        reviewTable.registerNib(nib, forCellReuseIdentifier: "reviewTableCell")
        self.course.text = self.courseData!["name"].string
        self.school.text = self.courseData!["school"].string;
        self.credits.text = String(self.courseData!["credits"].intValue)
        self.online.text = self.courseData!["online"].boolValue ? "Distans" : "Ortsbunden"
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
