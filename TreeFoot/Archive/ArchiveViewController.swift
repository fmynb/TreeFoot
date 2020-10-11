//
//  ArchiveViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/15.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

let ChangeCellIdentifier = "ChangeCellIdentifier"

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
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30.fit)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    func configNavbar() {
        self.pageIndex = 1
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChangeTableViewCell.classForCoder(), forCellReuseIdentifier: ChangeCellIdentifier)
        tableView.rowHeight = 300.fit
        tableView.separatorStyle = .none
        return tableView
    }()
}


extension ArchiveViewController: UITableViewDelegate {
    
}


extension ArchiveViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChangeCellIdentifier, for: indexPath) as! ChangeTableViewCell
        if indexPath.row == 1 {
            cell.backImageView.image = UIImage(named: "Weight")
        } else {
            cell.backImageView.image = UIImage(named: "BMI")
        }
        return cell
    }
    
    
}
