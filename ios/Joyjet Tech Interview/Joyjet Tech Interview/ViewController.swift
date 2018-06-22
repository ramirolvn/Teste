//
//  ViewController.swift
//  Joyjet Tech Interview
//
//  Created by Porgramacao iOS on 18/06/2018.
//  Copyright © 2018 ramiroLima. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeTableView.rowHeight = UITableViewAutomaticDimension
        self.homeTableView.estimatedRowHeight = 200
        JsonGetHelper.getJsonData(completionBlock: {e in
            if e != nil{
                print(e)
            }else{
                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                    
                }
            }
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allCategorys.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return allCategorys[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCategorys[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = allCategorys[indexPath.section].items[indexPath.row]
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
            categoryItemCell.itemImageView.imageFromURL(urlString: item.photosGaleryUrl[0])
            categoryItemCell.imageName = item.photosGaleryUrl[0]
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
                if let indexPath = self.homeTableView.indexPathForSelectedRow {
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
        if let currentCell = self.homeTableView.cellForRow(at: IndexPath(row: row, section: section)) as? CategoryItemCell{
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
        if let currentCell = self.homeTableView.cellForRow(at: IndexPath(row: row, section: section)) as? CategoryItemCell{
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

