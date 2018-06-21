//
//  GlobalFunctions.swift
//  Joyjet Tech Interview
//
//  Created by Porgramacao iOS on 21/06/2018.
//  Copyright © 2018 ramiroLima. All rights reserved.
//

import Foundation
import UIKit


func sizeToFitLabel(frame: CGRect, text: String, fontSize: CGFloat, bold: Bool) -> CGSize {
    let label = UILabel(frame: frame)
    label.textAlignment = NSTextAlignment.left
    label.font = bold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
    label.text = text
    label.numberOfLines = 60000
    let width = label.frame.size.width
    label.sizeToFit()
    var labelBounds = label.bounds
    labelBounds.size.width = width
    labelBounds.size.height = labelBounds.size.height < 21 ? 21 : labelBounds.size.height
    return labelBounds.size
}
