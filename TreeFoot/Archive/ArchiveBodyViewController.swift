//
//  ArchiveBodyViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/23.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

let BodyCellIdentifier = "BodyIdentifier"

class ArchiveBodyViewController: ArchiveBaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        view.backgroundColor =  UIColor(r: 254, g: 254, b: 254)
        view.corner(byRoundingCorners: [.topLeft,.topRight], radii: 20.fit)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20.fit)
            make.left.right.equalToSuperview().offset(0.fit)
            make.bottom.equalToSuperview()
        }
    }
    
    func configNavbar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        pageIndex = 1
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(BodyTableViewCell.classForCoder(), forCellReuseIdentifier: BodyCellIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 116.fit
        return tableView
    }()

}

extension ArchiveBodyViewController: UITableViewDelegate {
    
}

extension ArchiveBodyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BodyCellIdentifier, for: indexPath) as! BodyTableViewCell
        cell.updateUI(bodyData[indexPath.row])
        return cell
    }
    
    
}
