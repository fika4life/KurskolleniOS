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

class SearchViewController: UIViewController {

    @IBOutlet weak var courseField: UITextField!
    
    @IBOutlet weak var teacherField: UITextField!
    
    @IBOutlet weak var distanceField: UISwitch!
    
    var jsonData : JSON?
    
    
    
    @IBAction func Search(sender: AnyObject) {
        let course = courseField.text
        let teacher = teacherField.text
        let distance = distanceField.on
        let distanceString = distance ? "1" : "0"
        
        
        
        var parameters = [String: String]()
        if(course != ""){
            parameters["name"] = course
        }
        if(teacher != ""){
            parameters["teacher"] = teacher
        }
        parameters["teacher"] = distanceString

       
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueTest") {
            //var svc = segue.destinationViewController as ListViewControler;
            //svc.jsonData = self.jsonData
            
        }
    }
    //hides keyboard if user presses anywhere else on screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
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
