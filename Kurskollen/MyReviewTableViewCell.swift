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
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var myReviews: UITextView!
   
    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
