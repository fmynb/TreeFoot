//
//  AddViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/15.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

struct BagFood {
    let name: String
    let caloris: Int
}

class AddViewController: UIViewController {
    
    var searchVC: UISearchController!
    
    var searchResultVC: SearchResultViewController = SearchResultViewController()
    
    // MARK: - 私有变量
    private var addDatas = AddModel()
    private var data = [Ingredient]()
    private var type: IntakeOfType = .BreakFast
    // 背包总数
    private var bagCount = 0
    // 卡路里总数
    private var calorisCount = 0
    // 背包
    private var bagData = [BagFood]()
    
    convenience init(type: IntakeOfType) {
        self.init()
        self.type = type
    }
    
    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init(rawValue: "addBag"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init(rawValue: "deleteBag"), object: nil)
    }
    
    // 左边按钮
    private lazy var leftBarButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
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
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.register(AddFoodTableViewCell.classForCoder(), forCellReuseIdentifier: "reusedcell")
        return tableview
    }()
    
    lazy var bottomBarView: UIView = {
        let layerView = UIView()
        layerView.backgroundColor = UIColor(red: 0.99, green: 0.91, blue: 0.85, alpha: 1)
        layerView.layer.cornerRadius = 26
        layerView.alpha = 1
        return layerView
    }()
    
    lazy var countNumberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 1, green: 0.32, blue: 0.32, alpha: 1)
        label.layer.cornerRadius = 15.fit
        label.text = "\(self.bagCount)"
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = .white
        label.alpha = 1
        return label
    }()
    
    lazy var calorisLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "\(self.calorisCount)千卡")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 16)!,.foregroundColor: UIColor(red: 0.3, green: 0.29, blue: 0.27,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        label.textAlignment = .left
        return label
    }()
    
    lazy var achieveButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0.fit, y: 0.fit, width: 116.fit, height: 50.fit)
        button.backgroundColor = UIColor(red: 1, green: 0.68, blue: 0.5, alpha: 1)
        button.corner(byRoundingCorners: [.topRight, .bottomRight], radii: 26)
        let attrString = NSMutableAttributedString(string: "完成")
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Semibold", size: 18)!,.foregroundColor: UIColor(red: 1, green: 1, blue: 1,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        button.setAttributedTitle(attrString, for: .normal)
        button.addTarget(self, action: #selector(clickArchieveButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
        configData()
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(addItem), name: NSNotification.Name.init("addBag"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteItem), name: NSNotification.Name.init("deleteBag"), object: nil)
    }
    
    @objc func addItem(_ notification: Notification) {
        let userInfo = notification.userInfo as! [String: Any]
        let value = userInfo["caloris"] as! Int
        let name = userInfo["name"] as! String
//        print("name : \(name) + value : \(value)")
        let food = BagFood(name: name, caloris: value)
        var isHasFood = false
        for hasFood in bagData {
            if food.name == hasFood.name && food.caloris == hasFood.caloris {
                isHasFood = true
            }
        }
        if !isHasFood {
            bagData.append(food)
            bagCount = bagCount + 1
            calorisCount = calorisCount + value
            countNumberLabel.text = "\(bagCount)"
            calorisLabel.text = "\(calorisCount)千卡"
        }
    }
    
    @objc func deleteItem(_ notification: Notification) {
        let userInfo = notification.userInfo as! [String: Any]
        let value = userInfo["caloris"] as! Int
        let name = userInfo["name"] as! String
//        print("name : \(name) + value : \(value)")
        let food = BagFood(name: name, caloris: value)
        var isHasFood = false
        var deleteIndex = 0
        for (index, hasFood) in bagData.enumerated() {
            if food.name == hasFood.name && food.caloris == hasFood.caloris {
                isHasFood = true
                deleteIndex = index
            }
        }
        if isHasFood {
            bagData.remove(at: deleteIndex)
            bagCount = bagCount - 1
            calorisCount = calorisCount - value
            countNumberLabel.text = "\(bagCount)"
            calorisLabel.text = "\(calorisCount)千卡"
        }
    }
    
    private func configUI() {
        view.backgroundColor = .white
        definesPresentationContext = true
        view.backgroundColor = UIColor.white
        navigationItem.title = getIntakeOfTypeString(self.type)
        view.addSubview(tableView)
        view.addSubview(bottomBarView)
        bottomBarView.addSubview(countNumberLabel)
        bottomBarView.addSubview(calorisLabel)
        bottomBarView.addSubview(achieveButton)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10.fit)
            make.bottom.equalToSuperview().offset(-80.fit)
            make.left.right.equalToSuperview()
        }
        
        bottomBarView.snp.makeConstraints { (make) in
            make.height.equalTo(50.fit)
            make.left.equalToSuperview().offset(16.fit)
            make.right.equalToSuperview().offset(-16.fit)
            make.bottom.equalToSuperview().offset(-30.fit)
        }
        
        countNumberLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16.fit)
            make.width.height.equalTo(30.fit)
        }
        
        calorisLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.countNumberLabel.snp.right).offset(14.fit)
            make.centerY.equalToSuperview()
            make.width.equalTo(80.fit)
            make.height.equalTo(24.fit)
        }
        
        achieveButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(116.fit)
        }
    }
    
    func configNavbar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.automatic
            searchVC = UISearchController(searchResultsController: searchResultVC)
            searchVC.searchBar.placeholder = "请输入搜索内容"
            searchVC.searchResultsUpdater = self
            searchVC.delegate = self
            self.navigationItem.searchController = searchVC
            self.navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    
    func configData() {
        //1 获取json文件路径
        let path = Bundle.main.path(forResource: "add", ofType: "json")
        //2 获取json文件里面的内容,NSData格式
        let jsonData=NSData(contentsOfFile: path!)
        //3 解析json内
        let json = JSON(jsonData!)
        addDatas = JSONDeserializer<AddModel>.deserializeFrom(json: json["data"].description)!
        switch self.type {
        case .BreakFast:
            self.updateUI(with: addDatas.eats[0].content)
        case .Launch:
            self.updateUI(with: addDatas.eats[1].content)
        case .Dinner:
            self.updateUI(with: addDatas.eats[2].content)
        case .Snacks:
            self.updateUI(with: addDatas.eats[3].content)
        }
    }
    
    func updateUI(with data: [Ingredient]) {
        self.data = data
        self.tableView.reloadData()
    }
    
    @objc func clickArchieveButton() {
        // TODO: - Archieve
    }
}

extension AddViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusedcell") as! AddFoodTableViewCell
        cell.updateUI(with: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


class AddFoodTableViewCell: UITableViewCell {
    
    // 监听按钮点击
//    private var isClickAddButton = false {
//        didSet {
//            if (isClickAddButton) {
//                self.addButtonImageView.image = UIImage(named: "achieveAdd")
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addBag"), object: self, userInfo: ["caloris": self.ingredient.calorisNumber, "name": self.ingredient.name])
//            } else {
//                self.addButtonImageView.image = UIImage(named: "achieveAdd1")
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteBag"), object: self, userInfo: ["caloris": self.ingredient.calorisNumber, "name": self.ingredient.name])
//            }
//        }
//    }
    
    private var ingredient: Ingredient!
    
    public func updateUI(with data: Ingredient) {
        ingredient = data
        foodImageView.image = UIImage(named: data.image)
        namelabel.text = "\(data.image) (\(data.dosage))"
        heatlabel.text = "\(data.calorisNumber)"
    }
    
    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "素食拼盘")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var namelabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "苹果")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 15)!,.foregroundColor: UIColor(red: 0.26, green: 0.26, blue: 0.26,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        label.textAlignment = .left
        return label
    }()
    
    lazy var heatlabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "53千卡/100g")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 14)!,.foregroundColor: UIColor(red: 0.26, green: 0.26, blue: 0.26,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1;
        return label
    }()
    
    lazy var addbutton: UIButton = {
        let button = UIButton(type: .custom)
       // button.addTarget(self, action: #selector(clickbutton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var addButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "achieveAdd1")
        return imageView
    }()
    
    lazy var lineView: UIView = {
        let layerView = UIView()
        // strokeCode
        layerView.layer.borderColor = UIColor(red: 0.96, green: 0.92, blue: 0.92, alpha: 1).cgColor
        layerView.layer.borderWidth = 1
        layerView.alpha = 1
        return layerView
    }()
    
    
    func configUI(){
        contentView.addSubview(foodImageView)
        contentView.addSubview(addButtonImageView)
        contentView.addSubview(addbutton)
        contentView.addSubview(heatlabel)
        contentView.addSubview(namelabel)
        contentView.addSubview(lineView)
        
        foodImageView.snp.makeConstraints{ (make) in
            make.height.equalTo(60.fit)
            make.width.equalTo(60.fit)
            make.top.equalToSuperview().offset(10.fit)
            make.left.equalToSuperview().offset(16.fit)
        }
        
        namelabel.snp.makeConstraints{ (make) in
            make.height.equalTo(20.fit)
            make.width.equalTo(300.fit)
            make.top.equalToSuperview().offset(20.fit)
            make.left.equalToSuperview().offset(96.fit)
        }
        
        heatlabel.snp.makeConstraints{ (make) in
            make.height.equalTo(20.fit)
            make.width.equalTo(300.fit)
            make.top.equalToSuperview().offset(44.fit)
            make.left.equalToSuperview().offset(96.fit)
        }
        
        addButtonImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-26.fit)
            make.width.equalTo(28.fit)
            make.height.equalTo(28.fit)
        }
        
        addbutton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-26.fit)
            make.width.equalTo(28.fit)
            make.height.equalTo(28.fit)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16.fit)
            make.right.equalToSuperview().offset(-16.fit)
            make.height.equalTo(1.fit)
            make.bottom.equalToSuperview().offset(-2.fit)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc func clickbutton(_ sender: UIButton) {
//        isClickAddButton = !isClickAddButton
//    }
    
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
