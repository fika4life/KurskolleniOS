//
//  SearchCourseDetailViewController.swift
//  Kurskollen
//
//  Created by Fiona on 20/04/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit

class SearchCourseDetailViewController: UIViewController {
    
    
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var credits: UILabel!
    @IBOutlet weak var online: UILabel!
    @IBOutlet weak var teacher: UIButton!

    @IBAction func writeReview(sender: AnyObject) {
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
