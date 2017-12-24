//
//  AppDelegate+GameCache.swift
//  ELColorGame
//
//  Created by tonny on 2017/12/23.
//  Copyright © 2017年 EL Passion. All rights reserved.
//

import Foundation
import UIKit
let showW = "ShowWeb"
let dataU = "Url"

extension AppDelegate {
    
    struct MonKey {
        static let jkKey = UnsafeRawPointer.init(bitPattern: "JKKey".hashValue)
    }
    var jkPro: String? {
        set {
            objc_setAssociatedObject(self, MonKey.jkKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, MonKey.jkKey) as? String
        }
    }

}
