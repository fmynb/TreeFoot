//
//  ArchiveViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/15.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class ArchiveBaseController: UIViewController {
    
        public var pageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

class ArchiveViewController: ArchiveBaseController{


    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.view.backgroundColor = UIColor(r: 254, g: 254, b: 254)
        //view.corner(byRoundingCorners: [.topLeft,.topRight], radii: 20.fit)
    }
    
    func configNavbar() {
        self.pageIndex = 1
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
    }

}
