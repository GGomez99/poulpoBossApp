//
//  arretTableVCCell.swift
//  appBus
//
//  Created by Clement ROIG on 16/02/2016.
//  Copyright © 2016 Guyllian Gomez. All rights reserved.
//

import UIKit

class arretTableVCCell: UITableViewCell {

    
    
    //MARK: properties
    @IBOutlet weak var DirectionLabel: UILabel!
    
    @IBOutlet weak var lineImage: UIImageView!
    
    @IBOutlet weak var lineNumber: UILabel!
    
    @IBOutlet weak var viaLabel: UILabel!
    
    @IBOutlet weak var passage1label: UILabel!
    
    @IBOutlet weak var passage2label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}