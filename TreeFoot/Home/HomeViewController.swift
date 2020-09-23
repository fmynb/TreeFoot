//
//  HomeViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/15.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
import FanMenu
import Macaw
import DKCamera
import HandyJSON
import SwiftyJSON

// MARK:  Register cellID
fileprivate let SearchCollectionViewCellID = "SearchCollectionViewCell"
fileprivate let DayRecommendCollectionViewCellID = "DayRecommendCollectionViewCell"
fileprivate let HomeHeaderViewID = "HomeHeaderView"
fileprivate let SupplementCollectionViewCellID = "SupplementCollectionViewCell"
fileprivate let SuggestCollectionViewCellID = "SuggestCollectionViewCell"
fileprivate let FavCollectionViewCellID = "FavCollectionViewCell"


class HomeViewController: UIViewController {

    // 数据源
    var homeData = DataClass()
    // 主界面控件
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        
        // 注册cell
        collection.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCellID)
        collection.register(DayRecommendCollectionViewCell.self, forCellWithReuseIdentifier: DayRecommendCollectionViewCellID)
        collection.register(SupplementCollectionViewCell.self, forCellWithReuseIdentifier: SupplementCollectionViewCellID)
        collection.register(SuggestCollectionViewCell.self, forCellWithReuseIdentifier: SuggestCollectionViewCellID)
        collection.register(FavCollectionViewCell.self, forCellWithReuseIdentifier: FavCollectionViewCellID)
        
        collection.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderViewID)
        
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    
    // 标签栏中间按钮
    lazy var fanMenu: FanMenu = {
       let fanMenu = FanMenu()
        let items = [
            ("breakfast", 0x9F85FF),
            ("lunch", 0x85B1FF),
            ("dinner", 0xFF703B),
            ("refreshments", 0xF55B58),
        ]
        fanMenu.button = FanMenuButton(
            id: "main",
            image: UIImage(named: "menu_plus"),
            color: Color(val: 0xF57555)
        )
        
        fanMenu.items = items.map { button in
            FanMenuButton(
                id: button.0,
                image: UIImage(named: "menu_\(button.0)"),
                color: Color(val: button.1)
            )
        }
               
        fanMenu.menuRadius = 90.0
        fanMenu.duration = 0.2
        fanMenu.interval = (Double.pi + Double.pi/6, Double.pi + 5 * Double.pi/6)
        fanMenu.radius = 25.0
        fanMenu.delay = 0.0
        fanMenu.onItemDidClick = { button in
            print("ItemDidClick: \(button.id)")
            switch button.id {
            case "breakfast":
                let vc = AddViewController()
                self.tabBarController?.present(vc, animated: true, completion: nil)
            default:
                break;
            }
            
        }

        fanMenu.onItemWillClick = { button in
            print("ItemWillClick: \(button.id)")
        }
               
        fanMenu.backgroundColor = .clear
        return fanMenu
    }()

    lazy var centerView:CenterUIView = {
       let vi = CenterUIView()
        
        return vi
    }()
    
    lazy var circleView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor(r: 248, g: 248, b: 248)
//        backView.layer.cornerRadius = 15.fit
//        backView.layer.masksToBounds = false
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = CGSize(width: 0, height: -3.fit)
        backView.layer.shadowOpacity = 0.2
        return backView
    }()
    
    lazy var coverView: UIView = {
       let vi = UIView()
        vi.backgroundColor = .white
        return vi
    }()
    
    // 相机
    lazy var camera: DKCamera = {
       let camera = DKCamera()
        camera.didCancel = {
            print("didCancel")

            self.dismiss(animated: true, completion: nil)
        }

        camera.didFinishCapturingImage = { (image: UIImage?, metadata: [AnyHashable : Any]?) in
            print("didFinishCapturingImage")
            
            self.dismiss(animated: true, completion: nil)
            if let image = image {
                let vc = RecognizeViewController(image: image)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        return camera
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
        configCenterButton()
        configData()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        fanMenu.updateNode()
    }
    
    func configUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints{ (make) in
             make.left.equalTo(self.view.snp.left).offset(0)
             make.right.equalTo(self.view.snp.right).offset(0)
             make.bottom.equalToSuperview()
            make.top.equalTo(self.navigation.bar.snp.top).offset(0.fit)
         }
    }
    
    func configNavbar() {
        self.navigation.bar.isHidden = true
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
    }

    func configCenterButton() {
        self.tabBarController?.tabBar.addSubview(centerView)
        // 设置按钮的位置
        let rect = self.tabBarController?.tabBar.frame
        let value = rect!.width / CGFloat(5)
        centerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(1.5 * value)
            make.height.equalTo(value)
        }
//        let circle = UIBezierPath(arcCenter:   CGPoint(x: 0.75 * value , y: 0), radius: 0.75 * value, startAngle: CGFloat(Double.pi), endAngle: CGFloat(2*Double.pi), clockwise: false)
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = circle.cgPath
//        shapeLayer.fillColor = UIColor.white.cgColor
//        //shapeLayer.strokeColor = UIColor.lightGray.cgColor
//
//        //shapeLayer.lineWidth = 2
//        shapeLayer.shadowColor = UIColor.black.cgColor
//        shapeLayer.shadowOffset = CGSize(width: 0, height: -3.fit)
//        shapeLayer.shadowOpacity = 0.2
//
//        centerView.layer.addSublayer(shapeLayer)
        
//        centerView.addSubview(circleView)
//        circleView.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(centerView.snp.top)
//            make.width.equalTo(1.5 * value)
//            make.height.equalTo(0.75 * value)
//        }
//        circleView.layer.cornerRadius = 0.75 * value
//        circleView.layer.masksToBounds = true
//        DispatchQueue.main.async {
//            self.circleView.corner(byRoundingCorners: [.bottomLeft,.bottomRight], radii:  0.75 * value)
//        }
//        centerView.addSubview(coverView)
//        coverView.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.bottom.equalTo(centerView.snp.top)
//            make.width.equalTo(2 * value)
//            make.height.equalTo(1 * value)
//        }
        centerView.addSubview(fanMenu)
        fanMenu.snp.makeConstraints { (make) in
            make.centerX.equalTo(centerView.snp.centerX)
            make.centerY.equalTo(centerView.snp.top).offset(0.fit)
            make.height.equalTo(value*3)
            make.width.equalTo(CFWidth/2)
        }
        
        print("加载中间按钮")
    }
    
    func configTabbar() {
        
    }
    
    func configData() {
        //1 获取json文件路径
        let path = Bundle.main.path(forResource: "homelist", ofType: "json")
        //2 获取json文件里面的内容,NSData格式
        let jsonData=NSData(contentsOfFile: path!)
        //3 解析json内容
        let json = JSON(jsonData!)
        homeData = JSONDeserializer<DataClass>.deserializeFrom(json: json["data"].description)!
//        homeData = JSONDeserializer<DataClass>.deserializeModelArrayFrom(json: json["data"].description)
    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCellID, for: indexPath) as! SearchCollectionViewCell
            cell.photoCallBack = { ()
                self.present(self.camera, animated: true, completion: nil)
            }
            cell.eatCallBack = { (text) in
                // 回调TODO：
                switch text {
                case "breakfast":
                    let vc = RecipeViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                default:
                    break;
                }
            }
            cell.updateUI(with: homeData.eats)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayRecommendCollectionViewCellID, for: indexPath) as! DayRecommendCollectionViewCell
            cell.updateUI(with: homeData.dayRecommend)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SupplementCollectionViewCellID, for: indexPath) as! SupplementCollectionViewCell
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestCollectionViewCellID, for: indexPath) as! SuggestCollectionViewCell
            cell.updateUI(with: homeData.suggest)
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavCollectionViewCellID, for: indexPath) as! FavCollectionViewCell
            cell.updateUI(with: homeData.fav)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavCollectionViewCellID, for: indexPath) as! FavCollectionViewCell
            return cell
        }
    }
    
    
}

extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: CFWidth, height: 220.fit)
        case 1:
            return CGSize(width: CFWidth, height: 310.fit)
        case 2:
            return CGSize(width: CFWidth, height: 200.fit)
        case 3:
            return CGSize(width: CFWidth, height: 300.fit)
        case 4:
            return CGSize(width: CFWidth, height: 250.fit)
        default:
             return CGSize(width: CFWidth, height: 0)
        }
            
    }
    
    // 头部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderViewID, for: indexPath) as? HomeHeaderView else {
            return UICollectionReusableView()
        }
        headerView.backgroundColor = .lightGray
        return headerView
    }
    // 头部高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: CFWidth, height: 0)
        }
        return CGSize(width: CFWidth, height: 10.fit)
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.fit, left: 0, bottom: 20.fit, right: 0)
        
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.fit
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.fit
    }
}


class CenterUIView: UIView {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01 ){
            return nil
        }
        let resultView  = super.hitTest(point, with: event)
        if resultView != nil {
            return resultView
        } else {
            for subView in self.subviews.reversed() {
                let convertPoint : CGPoint = subView.convert(point, from: self)
                let hitView = subView.hitTest(convertPoint, with: event)
                if (hitView != nil) {
                    return hitView
                }
            }
        }
        return nil
    }
}

