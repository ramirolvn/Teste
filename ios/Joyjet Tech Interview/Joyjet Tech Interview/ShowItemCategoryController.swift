//
//  ShowItemCategoryController.swift
//  Joyjet Tech Interview
//
//  Created by Porgramacao iOS on 21/06/2018.
//  Copyright © 2018 ramiroLima. All rights reserved.
//

import UIKit

class ShowItemCategoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var itemTableView: UITableView!
    
    var itemShowing: CategoryItems!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemTableView.delegate = self
        self.itemTableView.dataSource = self
        self.itemTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: "showItemCell") as? ItemCell{
            itemCell.itemTitle.numberOfLines = 0
            itemCell.itemTitle.text = itemShowing.title
            itemCell.itemDescriptionHeight.constant = sizeToFitLabel(frame: itemCell.itemTitle.frame, text: itemShowing.title, fontSize: 20.0, bold: false).height
            itemCell.itemCategory.text = itemShowing.categoryName
            itemCell.itemDescription.numberOfLines = 0
            itemCell.itemImage.imageFromURL(urlString: itemShowing.photosGaleryUrl[0])
            itemCell.itemDescription.text = itemShowing.description
            itemCell.itemDescriptionHeight.constant = sizeToFitLabel(frame: itemCell.itemDescription.frame, text: itemShowing.description, fontSize: 17.0, bold: false).height
            self.itemTableView.estimatedRowHeight = self.itemTableView.frame.height
            cellToReturn = itemCell
        }
        return cellToReturn
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        if let index = favoritesItem.index(where: { $0.title == itemShowing.title }) {
            favoritesItem.remove(at: index)
        }else{
            favoritesItem.append(itemShowing)
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
