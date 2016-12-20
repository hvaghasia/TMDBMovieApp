//
//  View+Helper.swift
//  MovieApp
//
//  Created by Hardik on 20/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addBottomBorder(color: UIColor) {
        addTopOrBottomBorderToSubLayer(color: color, y: self.frame.size.height - 1)
    }
    
    func addTopOrBottomBorderToSubLayer(color: UIColor, y: CGFloat) {
        let border = CALayer()
        let width = self.frame.size.width
        border.frame = CGRect(x: 0, y: y, width: width, height: 1)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}
