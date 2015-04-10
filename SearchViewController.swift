//
//  SearchViewController.swift
//  
//
//  Created by Fiona on 10/04/15.
//
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var courseField: UITextField!
    
    @IBOutlet weak var teacherField: UITextField!
    
    @IBOutlet weak var distanceField: UISwitch!
    
    @IBAction func Search(sender: AnyObject) {
        
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
