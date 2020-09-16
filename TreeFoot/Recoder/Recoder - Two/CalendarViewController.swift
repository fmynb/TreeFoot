//
//  CalendarViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.view.backgroundColor = .white
    }
    
    func configNavbar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
    }

}
