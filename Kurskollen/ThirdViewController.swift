//
//  ThirdViewController.swift
//  Kurskollen
//
//  Created by Fiona on 30/03/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit
import EDStarRating

class ThirdViewController: UIViewController, UITableViewDataSource {
    
    let savedCourses = [
    ("Databaser", "KTH", "***"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****")]

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCourses.count
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let (course, school, rating) = savedCourses[indexPath.row]
        cell.textLabel?.text  = course
        cell.detailTextLabel?.text = school
        cell.detailTextLabel?.text = rating
        
        //retreive an image
        var myImage = UIImage(named: "CellIcon")
        cell.imageView?.image = myImage
        
        return cell
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
