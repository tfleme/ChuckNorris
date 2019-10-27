//
//  ScreenSize.swift
//  ApplicationTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit

enum ScreenSizes: CaseIterable {
    
    case iPhoneXR //IphoneXS Max, IphoneXR
    case iPhoneX //IphoneX, IphoneXS
    case iPhone6Plus //Iphone 8 plus, Iphone 7plus
    case iPhone6 //Iphone 8
    case iPhone5 //Iphone SE
    
    var size: CGSize {
        switch self {
        case .iPhoneXR:
            return CGSize(width: 414, height: 896)
        case .iPhoneX:
            return CGSize(width: 375, height: 812)
        case .iPhone6Plus:
            return CGSize(width: 414, height: 736)
        case .iPhone6:
            return CGSize(width: 375, height: 667)
        case .iPhone5:
            return CGSize(width: 320, height: 568)
        }
    }
}
