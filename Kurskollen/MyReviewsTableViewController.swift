//
//  MyReviewsTableViewController.swift
//  Kurskollen
//
//  Created by Fiona on 05/05/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MyReviewsTableViewController: UITableViewController {
    
    var reviews: JSON? = nil
    
    
    
    


    //@IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register the nib
        var nib = UINib(nibName: "MyReviewTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "myReviews")



        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let (email, loginSession) = Util.getLoginCredentials()
        
        let parameters = ["email" : email, "loginsession" : loginSession]
        
        Alamofire.request(.GET, globalConstants.URL + "get-my-reviews", parameters: parameters)
            .validate()
            .responseJSON{(request,response, data, error) in self.view.endEditing(true)
                
                    
                    if(error != nil){
                        var alert = UIAlertController(title: "Communication error", message: "Could not communicate with server", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else{
                        self.reviews = JSON(data!)
                        self.tableView.reloadData()
                        println(self.reviews)
                    }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (self.reviews == nil){
            return 0
        }
        return self.reviews!.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("myReviews", forIndexPath: indexPath) as MyReviewTableViewCell

        // Configure the cell...
        
        let review :JSON = self.reviews![indexPath.row]
 
        
        
        
        if let acourse = review["courseName"].string{
            cell.course.text   = acourse

        }else {
            //Print the error
            println(review["courseName"])
        }
        
        if let aSchool  = review["schoolName"].string{
            cell.school.text = aSchool
        }else {
            //Print the error
            println(review["schoolName"])
        }
        
        
        if let arating = review["rating"].int{
            cell.myRating.text = String (arating)
        }else {
            //Print the error
            println(review["rating"])
        }
    
        if let aTime = review["time"].double{
            cell.theTime.text = Util.formatTimeSwedishStyle(aTime)
        }else {
            //Print the error
            println(review["time"])
        }
        
        if let aText = review["text"].string{
             cell.myReviews.text = aText
        }else {
            //Print the error
            println(review["text"])
        }

    


        return cell
    
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
