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
    
    var initialFrame = CGRect(x: 0, y: 0, width: CFWidth, height: 300.fit)
    
    // MARK: - 顶部导航栏
    
    lazy var titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 390, height: kNavBarHeight))
        view.addSubview(self.leftBackImageView)
        view.addSubview(self.leftButton)
        view.addSubview(self.rightShareImageView)
        view.addSubview(self.rightButton)
        return view
    }()
    
    lazy var leftBackImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "back"))
        imageView.frame = CGRect(x: 10.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        return imageView
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        button.addTarget(self, action: #selector(clickLeftBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 390 - 40.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        button.addTarget(self, action: #selector(clickRightShareButton), for: .touchUpInside)
        return button
    }()
    
    lazy var rightShareImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "share"))
        imageView.frame = CGRect(x: 390 - 40.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        return imageView
    }()
    
    
    
    lazy var bgImage: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: CFWidth, height: 300.fit))
        img.image = UIImage(named: "素食拼盘")
        return img
    }()
    
    lazy var tableViewHeader: RecipeDetailHeaderView = {
        let vi = RecipeDetailHeaderView(frame: CGRect(x: 0, y: 0, width: CFWidth, height: 300.fit))
        vi.backgroundColor = .white
        return vi
    }()
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.register(breakfastcell.classForCoder(), forCellReuseIdentifier: "reusedcell")
        tableview.register(CalendarHeaderViewCell.self, forHeaderFooterViewReuseIdentifier: "cell")
        tableview.tableHeaderView = bgImage
        tableview.backgroundColor = .clear
        return tableview
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
        self.view.backgroundColor = .white
        self.view.addSubview(bgImage)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.right.left.equalTo(view)
            make.top.equalTo(view).offset(-kNavBarAndStatusBarHeight)
            make.bottom.equalTo(view)
        }
        DispatchQueue.main.async {
            self.tableViewHeader.corner(byRoundingCorners: [.topRight,.topLeft], radii: 35.fit)
        }
    }
    
    func configNavbar() {
        // 状态栏白色
        self.navigation.bar.statusBarStyle = .lightContent
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


extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK:- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [2,20][section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusedcell") as! breakfastcell
        cell.foodimageview.image = UIImage(named: "素食拼盘")
        return cell
    }
    
    
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.fit
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.fit
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "cell") as! CalendarHeaderViewCell
        return headerView
    }
    
}

extension RecipeDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        let initialOffsetY: CGFloat =  -88
        if y <= initialOffsetY {
            //下拉的偏移量；
            let offsetY = (y + (scrollView.contentInset.top )) * -1
            initialFrame.origin.y = -offsetY * 1 //设置上下拉伸的幅度；
            initialFrame.origin.x = -offsetY / 2 //设置左右拉伸的幅度；
            
            //重新设置view的frame（高度和宽度加上offsetY偏移量，达到图片放大的效果）；
            initialFrame.size.width = tableView.frame.size.width + offsetY
            initialFrame.size.height = 300.fit + offsetY
            bgImage.frame = initialFrame
            print(initialFrame.size)
        }
    }
}
