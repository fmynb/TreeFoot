//
//  EditUserInfoViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
let editid="reusedcell"
let bodycell="EditBodyTableViewCell"
let headercell="EditHeaderTableViewCell"

let bodydata:[EditModel] = [EditModel(leftText: "修改名字", centerText: "去冰无糖"),EditModel(leftText: "身高", centerText: "168cm"),EditModel(leftText: "体重", centerText: "52kg"),EditModel(leftText: "性别", centerText: "女"),EditModel(leftText: "生日", centerText: "2001-07-15")]

class EditUserInfoViewController: UIViewController {

    
    private lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.isScrollEnabled = false
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
        tableview.register(EditBodyTableViewCell.classForCoder(), forCellReuseIdentifier: bodycell)
        tableview.register(EditHeaderTableViewCell.classForCoder(), forCellReuseIdentifier: headercell)
        return tableview
    }()
    
    lazy var editordatalabel:UILabel = {
        let label = UILabel()
        label.text = "编辑资料"
        label.numberOfLines = 0
        label.font = UIFont(name: "PingFang SC", size: 16)
        label.textColor = UIColor(red: 0.57, green: 0.54, blue: 0.54,alpha:1)
        label.alpha = 1
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.view.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
        view.addSubview(tableview)
        tableview.frame = CGRect(x: 0, y: 140, width: CFWidth, height: CFHeight)
        self.navigation.bar.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
        self.view.addSubview(editordatalabel)
        editordatalabel.snp.makeConstraints{(make) in
            make.width.equalTo(128.fit)
            make.height.equalTo(22.fit)
            make.left.equalToSuperview().offset(22.fit)
            make.top.equalToSuperview().offset(100.fit)
        }
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
        
//        let cellid = "setCellID"
//        var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
//        if cell == nil {
//            cell = UITableViewCell(style: .value1, reuseIdentifier: cellid)
//        }
       
        //cell?.selectionStyle = .none
        if(indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: headercell) as! EditHeaderTableViewCell
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        else
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: bodycell) as! EditBodyTableViewCell
            let index = indexPath.row
            
      //修改字体
            cell.lefttext.numberOfLines = 0
            cell.lefttext.font = UIFont(name: "PingFang SC", size: 16)
            cell.lefttext.textColor = UIColor(red: 0.57, green: 0.54, blue: 0.54,alpha:1)
            cell.lefttext.alpha = 1;
            
            cell.centertext.numberOfLines = 0
            cell.centertext.font = UIFont(name: "PingFang SC", size: 16)
            cell.centertext.textColor = UIColor(red: 0.57, green: 0.54, blue: 0.54,alpha:1)
            cell.centertext.alpha = 1;
            switch index {
            case 1:
                cell.lefttext.text = bodydata[index-1].leftText
                cell.centertext.text = bodydata[index-1].centerText
            case 2:
                cell.lefttext.text = bodydata[index-1].leftText
                cell.centertext.text = bodydata[index-1].centerText
            case 3:
                cell.lefttext.text = bodydata[index-1].leftText
                cell.centertext.text = bodydata[index-1].centerText
            case 4:
                cell.lefttext.text = bodydata[index-1].leftText
                cell.centertext.text = bodydata[index-1].centerText
            case 5:
                cell.lefttext.text = bodydata[index-1].leftText
                cell.centertext.text = bodydata[index-1].centerText
            default :
                break
                
            }
            cell.accessoryType = .disclosureIndicator
            return cell
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0)
        {
            return 100
        }
        else
        {
        return 50
        }
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

