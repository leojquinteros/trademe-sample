//
//  UIColor+Custom.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 2/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgbValue: Int) {
        self.init(red:(rgbValue >> 16) & 0xff, green:(rgbValue >> 8) & 0xff, blue:rgbValue & 0xff)
    }
    
    struct Custom {
        struct NavBar {
            static let tint = UIColor(red: 255, green: 191, blue: 65)
            static let foreground = UIColor(red: 175, green: 82, blue: 15)
        }
        struct Foreground {
            static let tint = UIColor(red: 175, green: 82, blue: 15)
        }
        struct Background {
            static let tint = UIColor(red: 255, green: 253, blue: 241)
        }
    }
}
