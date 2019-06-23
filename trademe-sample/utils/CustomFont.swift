//
//  CustomFont.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 20/06/19.
//  Copyright © 2019 Leonel Quinteros. All rights reserved.
//

import UIKit

struct Font {
    
    enum FontType {
        case installed(FontName)
        case custom(String)
        case system
        case systemBold
        case systemItatic
    }
    
    enum FontSize {
        case standard(StandardSize)
        case custom(Double)
        var value: Double {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }
    
    enum FontName: String {
        case HelveticaNeue = "HelveticaNeue"
        case HelveticaNeueLight = "HelveticaNeue-Light"
        case HelveticaNeueBold = "HelveticaNeue-Bold"

    }
    enum StandardSize: Double {
        case h1 = 20.0
        case h2 = 18.0
        case h3 = 16.0
        case h4 = 14.0
        case h5 = 12.0
        case h6 = 10.0
    }
    
    var type: FontType
    var size: FontSize
    
    init(_ type: FontType, size: FontSize) {
        self.type = type
        self.size = size
    }
}

extension Font {
    
    var instance: UIFont {
        
        var instanceFont: UIFont!
        switch type {
        case .custom(let fontName):
            guard let font =  UIFont(name: fontName, size: CGFloat(size.value)) else {
                fatalError("\(fontName) font is not installed")
            }
            instanceFont = font
        case .installed(let fontName):
            guard let font =  UIFont(name: fontName.rawValue, size: CGFloat(size.value)) else {
                fatalError("\(fontName.rawValue) font is not installed)")
            }
            instanceFont = font
        case .system:
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value))
        case .systemBold:
            instanceFont = UIFont.boldSystemFont(ofSize: CGFloat(size.value))
        case .systemItatic:
            instanceFont = UIFont.italicSystemFont(ofSize: CGFloat(size.value))
        }
        return instanceFont
    }
}

class Utility {
    
    class func logAllAvailableFonts() {
        for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
}
