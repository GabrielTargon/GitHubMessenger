//
//  UIDevice+Extension.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 18/06/20.
//  Copyright © 2020 Gabriel Targon. All rights reserved.
//

import UIKit

extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhones4 = "iPhone 4 or iPhone 4S"
        case iPhones5 = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones4inchAndLower = "iPhone 4, iPhone 4S, iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones6 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhonesPlus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhonesX = "iPhone X or iPhone XS"
        case iPhoneXR = "iPhone XR"
        case iPhoneXSMax = "iPhone XS Max"
        case unknown
    }
    
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960,
             1136:
            return .iPhones4inchAndLower
        case 1334:
            return .iPhones6
        case 1920, 2208:
            return .iPhonesPlus
        case 1792, 2436, 2688, 2778:
            return .iPhonesX
        default:
            return .unknown
        }
    }
}
