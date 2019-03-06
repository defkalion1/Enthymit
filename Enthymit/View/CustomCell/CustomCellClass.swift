//
//  CustomCell.swift
//  Enthymit
//
//  Created by Defkalion on 05/03/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit

class CustomCategoryCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var customView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customView.layer.cornerRadius = 10
        customView.layer.masksToBounds = true
        // Initialization code
    }
    
}
