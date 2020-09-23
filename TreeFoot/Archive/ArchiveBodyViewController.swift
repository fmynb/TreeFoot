//
//  ArchiveBodyViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/23.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class ArchiveBodyViewController: ArchiveBaseController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.view.backgroundColor =  UIColor(r: 254, g: 254, b: 254)
        view.corner(byRoundingCorners: [.topLeft,.topRight], radii: 20.fit)
    }
    
    func configNavbar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        pageIndex = 1
    }

}
