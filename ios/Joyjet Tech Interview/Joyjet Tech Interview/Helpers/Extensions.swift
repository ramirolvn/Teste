//
//  Extensions.swift
//  Joyjet Tech Interview
//
//  Created by Porgramacao iOS on 19/06/2018.
//  Copyright © 2018 ramiroLima. All rights reserved.
//

import UIKit

extension UIViewController{
    var mainNav : UINavigationController {
        let mainstoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainstoryBoard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
    }
    
    var mainStoryBoard : UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func showMenu(){
        if let menuCntrl = mainStoryBoard.instantiateViewController(withIdentifier: "menuCntrl") as? MenuController{
            menuCntrl.modalPresentationStyle = .custom
            menuCntrl.modalTransitionStyle = .crossDissolve
            self.present(menuCntrl, animated: true, completion: {
                menuCntrl.view.backgroundColor = UIColor.clear
            })
        }
    }
}

extension UIImageView {
    public func imageFromURL(urlString: String) {
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        if self.image == nil{
            self.addSubview(activityIndicator)
        }
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                self.image = image
            })
            
        }).resume()
    }
}

extension UIImage{
    func imageWithColor(_ color: UIColor) -> UIImage {
        var newImage = self
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        if let context = UIGraphicsGetCurrentContext(){
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setBlendMode(.normal)
            let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            if let cgImage = self.cgImage{
                context.clip(to: rect, mask: cgImage)
                context.fill(rect)
                if let nImage = UIGraphicsGetImageFromCurrentImageContext(){
                    UIGraphicsEndImageContext()
                    newImage = nImage
                    return newImage
                }else{
                    return self
                }
            }else{
                return self
            }
        }else{
            return self
        }
    }
}
