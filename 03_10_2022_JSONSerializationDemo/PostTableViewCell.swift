//
//  PostTableViewCell.swift
//  03_10_2022_JSONSerializationDemo
//
//  Created by Vishal Jagtap on 17/11/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postIdLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
