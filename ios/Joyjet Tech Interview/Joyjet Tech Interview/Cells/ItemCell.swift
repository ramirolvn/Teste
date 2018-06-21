//
//  ItemCell.swift
//  Joyjet Tech Interview
//
//  Created by Porgramacao iOS on 21/06/2018.
//  Copyright © 2018 ramiroLima. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemCategory: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var itemDescriptionHeight: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
