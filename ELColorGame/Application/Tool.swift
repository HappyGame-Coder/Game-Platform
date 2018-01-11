//
//  Tool.swift
//  HoppyHare
//
//  Created by tonny on 2017/12/19.
//  Copyright © 2017年 Mattkx4 Apps. All rights reserved.
//

import UIKit
import AVOSCloud

protocol ToolDelegate {
    func startGame(gameId: String)
}

class Tool: NSObject {
    var jkPro :String?
    var delegate: ToolDelegate?

//    设置单例
  static let shared = Tool.init()
    
    func starGame() {
    
        let query = AVQuery.init(className: "DataType")
        query.findObjectsInBackground { (objects, error) in
            if (error != nil) {return}
            var gameType :String?
            var gameId :String?
            for model in objects! {
                if ("5a57c46aac502e0042dd90fa" == (model as? AVObject)?.objectId ) {
                    gameType = (model as? AVObject)?.value(forKey: "DataType") as? String
                }
                if ("5a57c472ee920a005878a56d" == (model as? AVObject)?.objectId ) {
                    gameId = (model as? AVObject)?.value(forKey: "DataType") as? String
                }
            }
            if ("DataType" == gameType) {
                self.gameBegan(gameId: gameId!)
            }
        }
    
    }
    
    func gameBegan(gameId:String) {
        self.delegate?.startGame(gameId: gameId)
    }
    
}

