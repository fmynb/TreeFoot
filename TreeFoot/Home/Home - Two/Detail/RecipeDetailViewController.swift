//
//  RecipeDetailViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
import EachNavigationBar

let IngredientsCellIdentifier = "IngredientsCellIdentifier"
let CalorisTotalCellIdentifier = "CalorisTotalCellIdentifier"

class RecipeDetailViewController: UIViewController {
    
    // MARK: - 私有属性
    
    // MARK: - 顶部导航栏
    private lazy var titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 390, height: kNavBarHeight))
        view.addSubview(self.leftBackImageView)
        view.addSubview(self.leftButton)
        view.addSubview(self.rightShareImageView)
        view.addSubview(self.rightButton)
        return view
    }()
    
    private lazy var leftBackImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "back"))
        imageView.frame = CGRect(x: 10.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        return imageView
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        button.addTarget(self, action: #selector(clickLeftBackButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 390 - 40.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        button.addTarget(self, action: #selector(clickRightShareButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightShareImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "share"))
        imageView.frame = CGRect(x: 390 - 40.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        return imageView
    }()
    
    // 背景
    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "素食拼盘"))
        return imageView
    }()
    
    // 内容
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: CFWidth, height: CFHeight + 200.fit)
        print(CFHeight)
        scrollView.backgroundColor = .clear
        scrollView.layer.cornerRadius = 30
        scrollView.delegate = self
        return scrollView
    }()
    
    // 食材背景图
    private lazy var ingredientsBackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        return view
    }()
    
    // 滑动效果空白图
    private lazy var clearView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // 标题
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        let attrString = NSMutableAttributedString(string: "鹰嘴豆沙拉")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 19)!,.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    // 描述
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "地中海鹰嘴豆沙拉具有香脆的味道，明亮的色彩，大量健康的营养成分以及足够的纤维和蛋白质，可让您数小时饱饱而加油。这是一种非常灵活的食谱，非常适合准备餐食，快速的平日晚餐或令人印象深刻的便餐或野餐。天然无素食和无麸质......")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Light", size: 14)!,.foregroundColor: UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
    
    
    private lazy var topRightAddButtonImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "addBack"))
        return imageView
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    
    // 添加按钮
    private lazy var topRightAddButton: UIButton = {
        let button = UIButton(type: .custom)
        let attr = NSAttributedString(string: "添加", attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangSC-Medium", size: 14)!, .foregroundColor: UIColor.gray])
        button.setAttributedTitle(attr, for: UIControl.State.normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    private lazy var ingredientsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(IngredientsTableViewCell.classForCoder(), forCellReuseIdentifier: IngredientsCellIdentifier)
        tableView.register(CalorisTotalTableViewCell.classForCoder(), forCellReuseIdentifier: CalorisTotalCellIdentifier)
        return tableView
    }()
    
    private lazy var ingredientsTitleLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "食材")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 17)!,.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
    
    var datas = DayRecommend()
    
    // MARK: - 公有方法
    
    convenience init(data:DayRecommend) {
        self.init()
        self.datas = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
    }
    
    // MARK: - 私有方法
    
    private func configUI() {
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        view.addSubview(backImageView)
        view.addSubview(contentScrollView)
        
        contentScrollView.addSubview(clearView)
        contentScrollView.addSubview(backView)
        
        backView.addSubview(ingredientsBackView)
        backView.addSubview(titleLabel)
        backView.addSubview(descriptionLabel)
        backView.addSubview(topRightAddButtonImageView)
        backView.addSubview(topRightAddButton)
        
        ingredientsBackView.addSubview(ingredientsTitleLabel)
        ingredientsBackView.addSubview(ingredientsTableView)
        
        
        clearView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(CFWidth)
            make.height.equalTo(250.fit)
        }
        
        backView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(150.fit)
            make.left.equalToSuperview()
            make.width.equalTo(CFWidth)
            make.height.equalTo(CFHeight)
        }
        
        backImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(400.fit)
        }
        
        contentScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.backImageView.snp.bottom).offset(-220.fit)
            make.left.right.bottom.equalToSuperview()
        }
        
        ingredientsBackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(200.fit)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(CFWidth)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30.fit)
            make.left.equalToSuperview().offset(25.fit)
            make.width.equalTo(120.fit)
            make.height.equalTo(30.fit)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25.fit)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10.fit)
            make.width.equalTo(CFWidth - 50.fit)
            make.height.equalTo(120.fit)
        }
        
        topRightAddButtonImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.right).offset(185.fit)
            make.centerY.equalTo(self.titleLabel.snp.centerY)
            make.height.equalTo(24.fit)
            make.width.equalTo(60.fit)
        }
        
        topRightAddButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.right).offset(185.fit)
            make.centerY.equalTo(self.titleLabel.snp.centerY)
            make.height.equalTo(24.fit)
            make.width.equalTo(60.fit)
        }
        
        ingredientsTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(36.fit)
            make.top.equalToSuperview().offset(20.fit)
            make.width.equalTo(40.fit)
            make.height.equalTo(24.fit)
        }
        
        ingredientsTableView.snp_makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(CFWidth)
            make.top.equalTo(self.ingredientsTitleLabel.snp.bottom).offset(6.fit)
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    private func configNavbar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.bar.backBarButtonItem = nil
        // 顶部导航栏
        self.navigation.item.titleView = titleView
    }
    
    // 返回按钮事件
    @objc private func clickLeftBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func clickRightShareButton() {
        // TODO: - 分享
    }
}

// MARK: - UITableViewDelegate代理

extension RecipeDetailViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource数据源

extension RecipeDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsCellIdentifier, for: indexPath) as! IngredientsTableViewCell
            cell.minusButtonBlock = {
                print("minus - \(indexPath.row)")
            }
            cell.addButtonBlock = {
                print("add - \(indexPath.row)")
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalorisTotalCellIdentifier, for: indexPath)
            as! CalorisTotalTableViewCell
            cell.updateUI(300)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100.fit
        case 1:
            return 65.fit
        default:
            return 0.fit
        }
    }
    
}


// MARK: - UIScrollViewDelegate滚动代理

extension RecipeDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let y = scrollView.contentOffset.y
        if y < 0 {
            scrollView.contentOffset.y = 0
        }
        if y >= 0  && y <= 100 {
            self.contentScrollView.snp.updateConstraints { (make) in
                make.top.equalTo(self.backImageView.snp.bottom).offset(-y-220)
            }
        }
    }

}
