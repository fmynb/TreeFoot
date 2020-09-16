//
//  EditUserInfoViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class EditUserInfoViewController: UIViewController {

    
    private lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.view.backgroundColor = .white
        view.addSubview(tableview)
        tableview.frame = CGRect(x: 0, y: 0, width: CFWidth, height: CFHeight)
        self.navigation.bar.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
    }
    
    func configNavbar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 1
        self.navigation.item.title = "编辑资料"
    }

}


extension EditUserInfoViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellid = "setCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellid)
        }
        cell?.accessoryType = .disclosureIndicator
        //cell?.selectionStyle = .none
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableview.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.row
        var url: URL?
        switch index {
        case 0:
            url = URL(string: String(format: "mqq://im/chat?chat_type=wpa&uin=\(1525163730)&version=1&src_type=web"))
        case 1:
            url = URL(string: "sinaweibo://userinfo?uid=6360764560")
        case 2:
             url = URL(string: "mailto:zc@zhangchione.cc")
        case 3:
             url = URL(string: "sms:1525163730@qq.com")
        case 4:
            url = URL(string: "telprompt://15274737502")
        case 5:
            url = nil
        default:
            break
        }
        if let u = url {
            
        }
        
    }
    
}
