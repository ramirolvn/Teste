//
//  FavoritesController.swift
//  Joyjet Tech Interview
//
//  Created by Porgramacao iOS on 19/06/2018.
//  Copyright © 2018 ramiroLima. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoritesTableView.delegate = self
        self.favoritesTableView.dataSource = self
        self.favoritesTableView.rowHeight = UITableViewAutomaticDimension
        self.favoritesTableView.estimatedRowHeight = 200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = favoritesItem[indexPath.row]
        var cellToReturn = UITableViewCell()
        if let categoryItemCell = tableView.dequeueReusableCell(withIdentifier: "categoryItem") as? CategoryItemCell{
            categoryItemCell.leftButton.tag = (indexPath.section * 1000) + indexPath.row
            categoryItemCell.rightButton.tag = (indexPath.section * 1000) + indexPath.row
            categoryItemCell.itemTitle.numberOfLines = 0
            categoryItemCell.itemSubtitle.numberOfLines = 0
            categoryItemCell.itemSubtitle.text = item.description.prefix(140) + "..."
            categoryItemCell.itemTitle.text = item.title
            categoryItemCell.titleHeight.constant = sizeToFitLabel(frame: categoryItemCell.itemTitle.frame, text: item.title, fontSize: 14.0, bold: false).height
            categoryItemCell.descriptionHeight.constant = sizeToFitLabel(frame: categoryItemCell.itemSubtitle.frame, text: item.description.prefix(140) + " ...", fontSize: 12.0, bold: false).height
            categoryItemCell.imageName = item.photosGaleryUrl[0]
            categoryItemCell.itemImageView.imageFromURL(urlString: item.photosGaleryUrl[0])
            cellToReturn = categoryItemCell
        }
        return cellToReturn
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showItem", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItem"{
            if let destinationVc: ShowItemController = segue.destination as? ShowItemController {
                if let indexPath = self.favoritesTableView.indexPathForSelectedRow {
                    let category = allCategorys[indexPath.section]
                    let selectedItem = category.items[indexPath.row]
                    destinationVc.itemShowing = selectedItem
                }
            }
        }
    }
    
    @IBAction func leftButtonAction(_ sender: UIButton) {
        let row = sender.tag % 1000
        let section = sender.tag / 1000
        let item = allCategorys[section].items[row]
        if let currentCell = self.favoritesTableView.cellForRow(at: IndexPath(row: row, section: section)) as? CategoryItemCell{
            if let index = item.photosGaleryUrl.index(where: { $0 == currentCell.imageName }) {
                switch currentCell.imageName{
                case item.photosGaleryUrl.first:
                    currentCell.itemImageView.imageFromURL(urlString: item.photosGaleryUrl.last!)
                    currentCell.imageName = item.photosGaleryUrl.last!
                    break
                default:
                    currentCell.itemImageView.imageFromURL(urlString: item.photosGaleryUrl[index-1])
                    currentCell.imageName = item.photosGaleryUrl[index-1]
                    break
                }
            }
        }
    }
    
    @IBAction func rightButtonAction(_ sender: UIButton) {
        let row = sender.tag % 1000
        let section = sender.tag / 1000
        let item = allCategorys[section].items[row]
        if let currentCell = self.favoritesTableView.cellForRow(at: IndexPath(row: row, section: section)) as? CategoryItemCell{
            if let index = item.photosGaleryUrl.index(where: { $0 == currentCell.imageName }) {
                switch currentCell.imageName{
                case item.photosGaleryUrl.first:
                    currentCell.itemImageView.imageFromURL(urlString: item.photosGaleryUrl[1])
                    currentCell.imageName = item.photosGaleryUrl[1]
                    break
                case item.photosGaleryUrl.last:
                    currentCell.itemImageView.imageFromURL(urlString: item.photosGaleryUrl[0])
                    currentCell.imageName = item.photosGaleryUrl[0]
                    break
                default:
                    currentCell.itemImageView.imageFromURL(urlString: item.photosGaleryUrl[index+1])
                    currentCell.imageName = item.photosGaleryUrl[index+1]
                    break
                }
            }
        }
    }
    
    
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        self.showMenu()
    }
    
    
}
