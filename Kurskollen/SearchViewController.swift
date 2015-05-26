//
//  SearchViewController.swift
//  
//
//  Created by Fiona on 10/04/15.
//
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreActionSheetPicker

class SearchViewController: UIViewController {

    @IBOutlet weak var courseField: UITextField!
    
    @IBOutlet weak var courseCodeField: UITextField!
    @IBOutlet weak var teacherField: UITextField!
    
    @IBOutlet weak var distanceField: UISwitch!
    
    var schoolId = 1;
    
    @IBAction func SchoolPicker(sender: AnyObject) {
        ActionSheetStringPicker.showPickerWithTitle("Välj skola", rows: globalConstants.SCHOOLS.values, initialSelection: 1, doneBlock: {
            picker, value, index in
            
            self.schoolId =  Util.allKeysForValue(globalConstants.SCHOOLS,value)[0];
            
            println("value = \(value)")
            println("index = \(index)")
            println("picker = \(picker)")
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
        
    }
    @IBAction func addCourse(sender: AnyObject) {
    }
    
    
    
    
    var parameters = [String: String]()
    
    
    
    
    @IBAction func Search(sender: AnyObject) {
        let course = courseField.text
        let teacher = teacherField.text
        let onlineString = distanceField.on ? "1" : "0"
        
        let courseCode = courseCodeField.text
        
            
        
        if(course != ""){
            self.parameters["name"] = course
        }
        if(teacher != ""){
            self.parameters["teacher"] = teacher
        }
        if(courseCode != ""){
            self.parameters["coursecode"] = courseCode
        }
        
        self.parameters["online"] = onlineString
//        println("getting parameters")
        self.performSegueWithIdentifier("toSearchResults", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject!) {
        println("segue:" + segue!.identifier!)
        if (segue!.identifier == "toSearchResults") {
            var svc = segue!.destinationViewController as SearchResultsViewController;
            svc.parameters = self.parameters
//            println(self.parameters)
            
            
            
            
            
        }
    }
    //hides keyboard if user presses anywhere else on screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add right button
//        var b = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action:nil)
//        self.navigationItem.leftBarButtonItem = b
        
        self.distanceField.on = false

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
