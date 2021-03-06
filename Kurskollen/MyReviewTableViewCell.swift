//
//  MyReviewTableViewCell.swift
//  Kurskollen
//
//  Created by Fiona on 05/05/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit

class MyReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var course: UILabel!
   
    @IBOutlet weak var school: UILabel!
    
    @IBOutlet weak var myRating: UILabel!
    
    @IBOutlet weak var theTime: UILabel!
    
    
    @IBOutlet weak var myReviews: UITextView!
    
  
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myReviews.userInteractionEnabled = false
        self.myReviews.editable = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
