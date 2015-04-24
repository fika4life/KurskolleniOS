//
//  AddCourseViewController.swift
//  Kurskollen
//
//  Created by Fiona on 24/04/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit

class AddCourseViewController: UIViewController {
    
    @IBOutlet weak var school: UITextField!
    
    @IBOutlet weak var courseName: UITextField!

    @IBOutlet weak var courseDesc: UITextField!
    
    
    @IBOutlet weak var credits: UITextField!
    
    @IBOutlet weak var online: UISwitch!

    @IBOutlet weak var teacher: UITextField!
    
    @IBAction func Done(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.online.on  = false
        
        
        

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
