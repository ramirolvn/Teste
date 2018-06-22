//
//  ShowItemController.swift
//  Joyjet Tech Interview
//
//  Created by Porgramacao iOS on 22/06/2018.
//  Copyright © 2018 ramiroLima. All rights reserved.
//

import UIKit

class ShowItemController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemCategory: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var itemDescriptionHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var itemShowing: CategoryItems!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoriteButton.imageView?.image = self.favoriteButton.imageView?.image?.imageWithColor(.white)
        self.itemTitle.numberOfLines = 0
        self.itemTitle.text = itemShowing.title
        self.itemTitleHeight.constant = sizeToFitLabel(frame: self.itemTitle.frame, text: itemShowing.title, fontSize: 20.0, bold: false).height
        self.itemCategory.text = itemShowing.categoryName
        self.itemDescription.numberOfLines = 0
        self.imageItem.imageFromURL(urlString: itemShowing.photosGaleryUrl[0])
        self.itemDescription.text = itemShowing.description
        self.itemDescriptionHeight.constant = sizeToFitLabel(frame: self.itemDescription.frame, text: itemShowing.description, fontSize: 20.0, bold: false).height
        scrollView.frame = CGRect(x: 0, y: 20, width: self.view.frame.width-20, height: self.view.frame.height)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height +  self.itemDescriptionHeight.constant + self.itemTitleHeight.constant)
        if let index = favoritesItem.index(where: { $0.title == itemShowing.title }) {
            favoritesItem.remove(at: index)
            self.favoriteButton.setImage(UIImage(named: "star_highligeted"), for: .normal)
        }else{
            favoritesItem.append(itemShowing)
            self.favoriteButton.setImage(UIImage(named: "ic_star"), for: .normal)
        }
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func favoriteAction(_ sender: UIButton) {
        if let index = favoritesItem.index(where: { $0.title == itemShowing.title }) {
            favoritesItem.remove(at: index)
            self.favoriteButton.setImage(UIImage(named: "ic_star"), for: .normal)
        }else{
            favoritesItem.append(itemShowing)
            self.favoriteButton.setImage(UIImage(named: "star_highligeted"), for: .normal)
        }
    }
    
}
