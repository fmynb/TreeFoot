//
//  AddViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/15.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    var searchVC: UISearchController!
    var searchResultVC: SearchResultViewController = SearchResultViewController()
    
    // 左边按钮
    private lazy var leftBarButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "custom_close")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.black
        button.tintColor = UIColor.black
        button.setImage(imageView.image, for: .normal)
        button.addTarget(self, action: #selector(leftClick), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    @objc func leftClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 右边按钮
    private lazy var rightBarButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 10, y: 0, width:30, height: 30)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mine_icon_set")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.black
        button.tintColor = UIColor.black
        button.setImage(imageView.image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(addClick), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    @objc func addClick() {
        let vc = RecognizeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
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
         definesPresentationContext = true
         view.backgroundColor = UIColor.white
         self.navigationItem.title = "早餐"


    }
    
    func configNavbar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
         if #available(iOS 11.0, *) {
             self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.automatic
        // self.navigationController?.navigationBar.prefersLargeTitles = true
             searchVC = UISearchController(searchResultsController: searchResultVC)
             searchVC.searchBar.placeholder = "请输入搜索内容"
             searchVC.searchResultsUpdater = self
             searchVC.delegate = self
             self.navigationItem.searchController = searchVC
             self.navigationItem.hidesSearchBarWhenScrolling = true
         }
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


extension AddViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {

    }
}

class SearchResultViewController: UITableViewController {

    var resultTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "resultCellID")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCellID")
        cell?.textLabel?.text = "result\(indexPath.row)"
        return cell!
    }

}
