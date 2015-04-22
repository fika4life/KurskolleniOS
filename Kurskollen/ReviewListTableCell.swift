//
//  ReviewListTableCell.swift
//  Kurskollen
//
//  Created by Fredrik Wallén on 20/04/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit

class ReviewListTableCell: UITableViewCell {

    
    @IBOutlet weak var reviewerNameText: UILabel!
    
    @IBOutlet weak var reviewText: UILabel!
    
    @IBOutlet weak var timeField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.reviewText.numberOfLines = 0
        self.reviewText.sizeToFit()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
