//
//  UILable + Extension.swift
//  WorkOut
//
//  Created by d vasylenko on 13.04.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String = "") {
        self.init()
        self.text = text
        self.font = .robotoMedium14()
        self.textColor = .specialBrown
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(text: String = "", font: UIFont!, fontColor: UIColor ) {
        self.init()
        self.text = text
        self.textColor = fontColor
        self.font = font
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
