//
//  MineViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/15.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let MineBodyTableViewCellID = "MineBodyTableViewCell"
fileprivate let MineHeaderTableViewCellID = "MineHeaderTableViewCell"

class MineViewController: UIViewController {

    var headerData = MineHeaderModel()
    var bodyDatas1 = [MineModel]()
    var bodyDatas2 = [MineModel]()
    
    lazy var topImage: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "mine_img_bg")
        return img
    }()
    
    // 右边按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
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
        
    }
    
    private lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(MineBodyTableViewCell.self, forCellReuseIdentifier: MineBodyTableViewCellID)
        tableview.register(MineHeaderTableViewCell.self, forCellReuseIdentifier: MineHeaderTableViewCellID)
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        tableview.showsVerticalScrollIndicator = false
        tableview.isScrollEnabled = false
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
        configData()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.view.backgroundColor = UIColor.init(r: 245, g: 245, b: 245)
        self.view.addSubview(self.topImage)
        self.topImage.snp.makeConstraints{ (make) in
             make.left.equalTo(self.view.snp.left).offset(0)
             make.right.equalTo(self.view.snp.right).offset(0)
            make.height.equalTo(270.fit)
            make.top.equalTo(self.navigation.bar.snp.top).offset(-kStatusBarHeight)
         }
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(5.fit)
            make.right.equalTo(view.snp.right).offset(-5.fit)
            make.top.equalTo(topImage.snp.bottom).offset(-80.fit)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    func configNavbar() {
        self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
    }
    
    func configData(){
        let data = MineHeaderModel(img: "mine_img_header", username: "去冰无糖", sex: "女", bodyweight: "52", height: "168")
        self.headerData = data
        self.bodyDatas1.append(MineModel(leftIcon: "", titleText: "本周食谱"))
        self.bodyDatas1.append(MineModel(leftIcon: "", titleText: "本周目标"))
        self.bodyDatas1.append(MineModel(leftIcon: "", titleText: "上周总结"))
        
        self.bodyDatas2.append(MineModel(leftIcon: "", titleText: "健康资料"))
        self.bodyDatas2.append(MineModel(leftIcon: "", titleText: "饮食方案"))
    }

}

extension MineViewController: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 3
        }else if section == 2 {
            return 2
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MineHeaderTableViewCellID, for: indexPath) as! MineHeaderTableViewCell
            cell.updateUI(with: self.headerData)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: MineBodyTableViewCellID, for: indexPath) as! MineBodyTableViewCell
        if indexPath.section == 1 {
            cell.updateUI(with: bodyDatas1[indexPath.row])
        }else if indexPath.section == 2{
            cell.updateUI(with: bodyDatas2[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100.fit
        }
        return 60.fit
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vi = UIView()
        vi.backgroundColor  = .clear
        return vi
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.fit
    }
}

// MARK: tableview delegete

extension MineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.tableview.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let vc = EditUserInfoViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.section == 1 {
            
        }else if indexPath.section == 2 {
            
        }
    }
}


// MARK: Cell UI
    
extension MineViewController {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 圆角角度
        let radius: CGFloat = 10.fit
        // 设置cell 背景色为透明
        cell.backgroundColor = UIColor.clear
        // 创建两个layer
        let normalLayer = CAShapeLayer()
        let selectLayer = CAShapeLayer()
        // 获取显示区域大小
        let bounds = cell.bounds.insetBy(dx:  20.fit, dy: 0)
        // cell的backgroundView
        let normalBgView = UIView(frame: bounds)
        // 获取每组行数
        let rowNum = tableView.numberOfRows(inSection: indexPath.section)
        // 贝塞尔曲线
        var bezierPath: UIBezierPath? = nil

        if rowNum == 1 {
            // 一组只有一行（四个角全部为圆角）
            bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
            normalBgView.clipsToBounds = false
        } else {
            normalBgView.clipsToBounds = true
            if indexPath.row == 0 {
                normalBgView.frame = bounds.inset(by: UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0))
                let rect = bounds.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
                // 每组第一行（添加左上和右上的圆角）
                bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
            } else if indexPath.row == rowNum - 1 {
                normalBgView.frame = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -5, right: 0))
                let rect = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
                // 每组最后一行（添加左下和右下的圆角）
                bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            } else {
                // 每组不是首位的行不设置圆角
                bezierPath = UIBezierPath(rect: bounds)
            }
        }
    
        
        // 阴影
        normalLayer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        normalLayer.shadowOpacity = 0.2
        normalLayer.shadowOffset = CGSize(width: 0, height: 0)
        normalLayer.path = bezierPath?.cgPath
        normalLayer.shadowPath = bezierPath?.cgPath

        // 把已经绘制好的贝塞尔曲线路径赋值给图层，然后图层根据path进行图像渲染render
        normalLayer.path = bezierPath?.cgPath
        selectLayer.path = bezierPath?.cgPath

        // 设置填充颜色
        normalLayer.fillColor = UIColor.white.cgColor
        // 添加图层到nomarBgView中
        normalBgView.layer.insertSublayer(normalLayer, at: 0)
        normalBgView.backgroundColor = UIColor.clear
        cell.backgroundView = normalBgView

        // 替换cell点击效果
        let selectBgView = UIView(frame: bounds)
        selectLayer.fillColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        selectBgView.layer.insertSublayer(selectLayer, at: 0)
        selectBgView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = selectBgView
        
    }
}
