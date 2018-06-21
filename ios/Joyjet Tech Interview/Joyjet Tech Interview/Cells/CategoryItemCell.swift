//
//  CategoryItemCell.swift
//  Joyjet Tech Interview
//
//  Created by Porgramacao iOS on 20/06/2018.
//  Copyright © 2018 ramiroLima. All rights reserved.
//

import UIKit

class CategoryItemCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemSubtitle: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
