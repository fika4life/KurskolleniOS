//
//  ThirdViewController.swift
//  Kurskollen
//
//  Created by Fiona on 30/03/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit
import EDStarRating
import Alamofire
import SwiftyJSON

class ThirdViewController: UIViewController, UITableViewDataSource {
    
    /*let savedCourses = [
    ("Databaser", "KTH", "***"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****"),("ProgramUtv", "KTH", "*****")]*/
    
    var savedCourses: JSON?

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(savedCourses == nil){
            return 0;
        }
        return savedCourses!.count
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("bookmarkListTableCell", forIndexPath: indexPath) as BookmarkListTableCell
        
        let courseInfo = savedCourses![indexPath.row]
        let meanRating = courseInfo["meanRating"].doubleValue
        cell.nameField.text  = courseInfo["name"].string
        cell.schoolField.text = courseInfo["school"].string
        cell.meanRatingField.text = String(format: "%.2f", courseInfo["meanRating"].doubleValue)
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            
            let userDefaults = NSUserDefaults.standardUserDefaults()
            let email = userDefaults.stringForKey(globalConstants.emailMemoryKey)
            let loginSession = userDefaults.stringForKey(globalConstants.loginSessionMemoryKey)
            
            let parameters : [String: String] = ["email" : email!, "loginsession" : loginSession!]
            
            Alamofire.request(.POST, globalConstants.URL + "remove-bookmark", parameters: parameters)
                .validate()
                .response{(_,_,_,error) in
                    if(error != nil){
                        var alert = UIAlertController(title: "Communication error", message: "Could not communicate with server", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else{
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    }
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "BookmarkListTableCell", bundle: nil)
        //tableView.registerNib(nib, forCellReuseIdentifier: "bookmarkListTableCell")
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let email = userDefaults.stringForKey(globalConstants.emailMemoryKey)
        let loginSession = userDefaults.stringForKey(globalConstants.loginSessionMemoryKey)
        
        let parameters : [String: String] = ["email" : email!, "loginsession" : loginSession!]

        Alamofire.request(.GET, globalConstants.URL + "get-my-bookmarks", parameters: parameters)
            .validate()
            .responseJSON{(request, response, data, error) in
                self.view.endEditing(true)
                if(error != nil){
                    var alert = UIAlertController(title: "Communication error", message: "Could not communicate with server", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else{
                    self.savedCourses = JSON(data!)
                    //self.tableView.reloadData()
                    println(self.savedCourses)
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
