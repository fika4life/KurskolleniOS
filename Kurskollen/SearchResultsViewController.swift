//
//  SearchResultsViewController.swift
//  Kurskollen
//
//  Created by Fiona on 15/04/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView!

    
    var parameters:[String: String]? = [:]
    
    let savedCourses = [
        ("Databaser", "KTH", "***"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****")]
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCourses.count
        
        
    }
    
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as UITableViewCell
        
        let (course, school, rating) = savedCourses[indexPath.row]
        cell.textLabel?.text  = course
        cell.detailTextLabel?.text = school
        cell.detailTextLabel?.text = rating
    cell.subviews
    
                return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        println(self.parameters)

        // Do any additional setup after loading the view.
        Alamofire.request(.GET, globalConstants.URL + "search-course", parameters: self.parameters)
            .validate()
            .responseJSON{(request, response, data, error) in
                self.view.endEditing(true)
                if(error != nil){
                    var alert = UIAlertController(title: "Communication error", message: "Could not communicate with server", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else{
                    println(data)
                    var jsonData = JSON(data!)
                    println(jsonData)
                }
            
        }
        
        tableView.delegate = self
        tableView.dataSource = self
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
