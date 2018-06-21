//
//  AcessoServerHelper.swift
//  Gestor Escolar
//
//  Created by Computex  on 21/06/17.
//  Copyright © 2017 Computex . All rights reserved.
//

import UIKit

class JsonGetHelper: NSObject {
    
    static func getJsonData(completionBlock: @escaping (_ error: String?) -> ()){
        if let url = URL(string: "https://cdn.joyjet.com/tech-interview/mobile-test-one.json"){
            let session = URLSession.shared
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                guard error == nil else {
                    return
                }
                guard let data = data else {
                    completionBlock("Error data")
                    return
                }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]] {
                        for c in json{
                            if let jsonCategoryName = c["category"] as? String, let jsonCategoryItems = c["items"] as? [[String:Any]]{
                                var cItems: [CategoryItems] = []
                                for i in jsonCategoryItems{
                                    if let itemTitle = i["title"] as? String, let itemDescription = i["description"] as? String, let itemGalery = i["galery"] as? [String]{
                                        cItems.append(CategoryItems(title: itemTitle, description: itemDescription, photosGaleryUrl: itemGalery, categoryName: jsonCategoryName))
                                    }
                                }
                                allCategorys.append(Category(name: jsonCategoryName, items: cItems))
                            }
                        }
                        completionBlock(nil)
                    }
                } catch let error {
                    completionBlock(error.localizedDescription)
                }
            })
            task.resume()
        }
    }
    
}
