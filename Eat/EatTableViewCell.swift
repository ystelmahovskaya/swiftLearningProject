//
//  EatTableViewCell.swift
//  Eat
//
//  Created by Yuliia Stelmakhovska on 2017-06-27.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit

class EatTableViewCell: UITableViewCell {

    
    

    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
