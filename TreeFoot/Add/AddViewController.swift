//
//  AddViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/15.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    
    lazy var breakfasttableview:UITableView = {
       let tableview = UITableView(frame: CGRect(x: 0, y: 0, width: CFWidth, height: CFHeight))
        tableview.delegate = self
        tableview.dataSource = self
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.register(breakfastcell.classForCoder(), forCellReuseIdentifier: "reusedcell")
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
        self.view.addSubview(breakfasttableview)
    }
    
    func configNavbar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
    }

}

extension AddViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusedcell") as! breakfastcell
        cell.foodimageview.image = UIImage(named: "素食拼盘")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.breakfasttableview.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


 class breakfastcell:UITableViewCell {
    
    lazy var foodimageview:UIImageView = {
       let imageview = UIImageView()
        imageview.backgroundColor = UIColor.black
        return imageview
    }()
    
    lazy var namelabel:UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "苹果")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 15),.foregroundColor: UIColor(red: 0.26, green: 0.26, blue: 0.26,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1;
        return label
    }()
    
    lazy var heatlabel:UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "53千卡/100g")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 14),.foregroundColor: UIColor(red: 0.26, green: 0.26, blue: 0.26,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1;
        return label
    }()
    
    lazy var addbutton:UIButton = {
        let button = UIButton(frame: CGRect(x: 350, y: 30, width: 30, height: 30))
       let image = UIImage(named: "menu_plus")
       button.setImage(image, for: .normal)
       button.backgroundColor = UIColor(red: 0.8, green: 0.78, blue: 0.78, alpha: 1)
       button.alpha = 1
       button.cornerRadius = 15
       button.addTarget(self, action: #selector(clickbutton), for: .touchUpInside)
       return button
    }()
    
    
    func configUI(){
        self.addSubview(foodimageview)
        self.addSubview(addbutton)
        foodimageview.snp.makeConstraints{ (make) in
            make.height.equalTo(61.fit)
            make.width.equalTo(61.fit)
            make.top.equalToSuperview().offset(10.fit)
            make.left.equalToSuperview().offset(15.fit)
        }
        self.addSubview(namelabel)
        namelabel.snp.makeConstraints{ (make) in
                  make.height.equalTo(21.fit)
                  make.width.equalTo(30.fit)
                  make.top.equalToSuperview().offset(20.fit)
                  make.left.equalToSuperview().offset(96.fit)
              }
        self.addSubview(heatlabel)
        heatlabel.snp.makeConstraints{ (make) in
                  make.height.equalTo(20.fit)
                  make.width.equalTo(85.fit)
                  make.top.equalToSuperview().offset(40.fit)
                  make.left.equalToSuperview().offset(96.fit)
              }
        
       }
    
    override func layoutSubviews() {
        configUI()
    }
    
    @objc func clickbutton(){
       // let image = UIImage(named: "shop_home")
        //self.addbutton.setImage(image, for: .normal)
    }
    
}
