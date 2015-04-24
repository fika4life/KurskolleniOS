//
//  BookmarkListTableCell.swift
//  Kurskollen
//
//  Created by Fredrik Wallén on 24/04/15.
//  Copyright (c) 2015 Fiona. All rights reserved.
//

import UIKit

class BookmarkListTableCell: UITableViewCell {

    @IBOutlet weak var nameField: UILabel!
    
    @IBOutlet weak var schoolField: UILabel!
    
    @IBOutlet weak var meanRatingField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
