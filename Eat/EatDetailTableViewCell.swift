//
//  EatDetailTableViewCell.swift
//  Eat
//
//  Created by Yuliia Stelmakhovska on 2017-06-29.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit

class EatDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
