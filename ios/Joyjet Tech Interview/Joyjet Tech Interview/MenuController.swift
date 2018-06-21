//
//  MenuController.swift
//  Joyjet Tech Interview
//
//  Created by Porgramacao iOS on 19/06/2018.
//  Copyright © 2018 ramiroLima. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    @IBOutlet weak var menuTrailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showHome(_ sender: UIButton) {
        if (self.presentingViewController?.childViewControllers.last as? ViewController) != nil {
            self.dismiss(animated: true, completion: nil)
        }else if let favoritesCntrl = self.presentingViewController?.childViewControllers.last as? FavoritesController{
            favoritesCntrl.navigationController?.popToRootViewController(animated: false)
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func showFavorites(_ sender: UIButton) {
        if (self.presentingViewController?.childViewControllers.last as? FavoritesController) != nil {
            self.dismiss(animated: true, completion: nil)
        }else if let vcCntrl = self.presentingViewController?.childViewControllers.last as? ViewController{
            if let favoritesCntrl = mainStoryBoard.instantiateViewController(withIdentifier: "favoritesCntrl") as? FavoritesController{
                vcCntrl.navigationController?.pushViewController(favoritesCntrl, animated: false)
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
}
