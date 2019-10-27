//
//  UIColor+Extensions.swift
//  Application
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var mainRed: UIColor {
        return UIColor(red: 0.975, green: 0.220, blue: 0.415, alpha: 1.0)
    }
    
    static var mainActivityIndicatorColor: UIColor {
        
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return .white
                } else {
                    return .gray
                }
            }
        } else {
            return .gray
        }
    }
    
    static var mainLoadingColor: UIColor {
        
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return .black
                } else {
                    return .white
                }
            }
        } else {
            return .darkGray
        }
    }
    
    static var mainBarColor: UIColor {
        
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return .systemBackground
                } else {
                    return .systemBackground
                }
            }
        } else {
            return .white
        }
    }
}
