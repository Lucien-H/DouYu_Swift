//
//  TableProfileNormalCell.swift
//  DouYu_Swift
//
//  Created by iwindy on 2020/9/12.
//  Copyright © 2020 Lucien. All rights reserved.
//

import UIKit

class TableProfileNormalCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
