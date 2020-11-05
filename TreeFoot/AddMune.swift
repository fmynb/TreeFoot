//
//  AddMune.swift
//  TreeFoot
//
//  Created by Ryan on 2020/10/25.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
import FanMenu
import Macaw
import DKCamera
import HandyJSON
import SwiftyJSON

// 单例模式
class AddMune: NSObject {
    private static var _sharedInstance: AddMune?
    
    public lazy var fanMenu: FanMenu = {
        let fanMenu = FanMenu()
        let items = [
            ("早餐", 0xFFFFFF),
            ("午餐", 0xFFFFFF),
            ("晚餐", 0xFFFFFF),
            ("小食", 0xFFFFFF),
        ]
        fanMenu.button = FanMenuButton(
            id: "main",
            image: UIImage(named: "menu_plus"),
            color: Color(val: 0xF57555)
        )
        
        fanMenu.items = items.map { button in
            FanMenuButton(
                id: button.0,
                image: UIImage(named: "\(button.0)"),
                color: Color(val: button.1)
            )
        }
        
        fanMenu.menuRadius = 120.0
        fanMenu.duration = 0.2
        fanMenu.interval = (Double.pi + Double.pi/6, Double.pi + 5 * Double.pi/6)
        fanMenu.radius = 25.0
        fanMenu.delay = 0.0
        fanMenu.backgroundColor = .clear
        return fanMenu
    }()

    public var achieveBlock: (() -> ())?
    
    public var breakfastRecord: [String: String] = [:]
    
    public var imageNames: [[String]] = [[], [], [], []]
    
    private override init() {
        
    }
    
    class func getSharedInstance() -> AddMune {
        guard let instance = _sharedInstance else {
            _sharedInstance = AddMune()
            return _sharedInstance!
        }
        return instance
    }
}


