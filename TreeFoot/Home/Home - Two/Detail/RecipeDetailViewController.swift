//
//  RecipeDetailViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
import EachNavigationBar

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
        scrollView.contentSize = CGSize(width: CFWidth, height: CFHeight)
        print(CFHeight)
        scrollView.backgroundColor = .clear
        scrollView.layer.cornerRadius = 30
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var ingredientsBackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        return view
    }()
    
    private lazy var clearView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
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
    
    private lazy var topRightAddButton: UIButton = {
        let button = UIButton(type: .custom)
        let attr = NSAttributedString(string: "添加", attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangSC-Medium", size: 14)!, .foregroundColor: UIColor.gray])
        button.setAttributedTitle(attr, for: UIControl.State.normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    private lazy var ingredientsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        return tableView
    }()
    
    var datas = DayRecommend()
    
    convenience init(data:DayRecommend) {
        self.init()
        self.datas = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
    }
    
    func configUI() {
        view.backgroundColor = .white
        view.addSubview(backImageView)
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(clearView)
        contentScrollView.addSubview(backView)
        backView.addSubview(ingredientsBackView)
        backView.addSubview(titleLabel)
        backView.addSubview(descriptionLabel)
        backView.addSubview(topRightAddButtonImageView)
        backView.addSubview(topRightAddButton)
        
        clearView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(CFWidth)
            make.height.equalTo(200.fit)
        }
        
        backView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(200.fit)
            make.left.equalToSuperview()
            make.width.equalTo(CFWidth)
            make.height.equalTo(CFHeight - 200.fit)
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
            make.height.equalTo(CFHeight - 200.fit)
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
    }
    
    func configNavbar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.bar.backBarButtonItem = nil
        // 顶部导航栏
        self.navigation.item.titleView = titleView
    }
    
    // 返回按钮事件
    @objc func clickLeftBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func clickRightShareButton() {
        // TODO: - 分享
    }
}


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
