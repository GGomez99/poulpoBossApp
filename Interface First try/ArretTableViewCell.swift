//
//  ArretTableViewCell.swift
//  Interface First try
//
//  Created by Guyllian Gomez on 10/12/2015.
//  Copyright © 2015 Guyllian Gomez. All rights reserved.
//

import UIKit

class ArretTableViewCell: UITableViewCell {

    
    //Names arrets
    @IBOutlet weak var nameArret: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
