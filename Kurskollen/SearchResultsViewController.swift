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

class SearchResultsViewController: UIViewController, UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    
    

    
    var parameters:[String: String]?
    
    var indexRow:Int?
    
    var courses: JSON? = nil;
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.courses == nil){
            return 0
        }
        
        return self.courses!.count
        
        
        
    }
    
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cellTest", forIndexPath: indexPath) as SearchResultsTableViewCell
    
    
    
        let course :JSON = self.courses![indexPath.row]
        cell.course.text  = course["name"].string
        cell.school.text = course["school"].string
        if let meanRating = course["meanRating"].double {
            cell.rating.text = String(format: "%.2f",meanRating)

        }
        else{
            cell.rating.text = ""
        }
    
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        self.indexRow = indexPath.row
        self.performSegueWithIdentifier("toSearchCell", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       let vc =  segue.destinationViewController as SearchCourseDetailViewController
        if let indexPath =  self.tableView.indexPathForSelectedRow(){
            let selectedCell = self.courses![self.indexRow!]
            vc.courseData = selectedCell
         
            
            
       }
        
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //change name of title
        self.title = "Sökresultat"
        
        
        
        //register custom cell
        var nib = UINib(nibName: "searchResultsTableCell", bundle: nil)
       tableView.registerNib(nib, forCellReuseIdentifier: "cellTest")
        
      
       

        // Do any additional setup after loading the view.
        Alamofire.request(.GET, globalConstants.URL + "search-course", parameters: self.parameters)
            .validate()
            .responseJSON{(request, response, data, error) in
                self.view.endEditing(true)
                if(error != nil){
                    var alert = UIAlertController(title: "Communication error", message: "There is an error", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
//                    println(error)
                }
                else{
                    self.courses = JSON(data!)
                    self.tableView.reloadData()
//                    println(self.courses)
                }
            
        }
        
       
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
