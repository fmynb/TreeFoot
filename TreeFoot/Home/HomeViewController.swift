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
    
    // MARK: - 私有属性
    
    // MARK: - 数据源
    
    private var homeData = DataClass()
    
    private lazy var collectionView: UICollectionView = {
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
    private lazy var fanMenu: FanMenu = {
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
            var vc = UIViewController()
            switch button.id {
            case "breakfast":
                vc = AddViewController(type: .BreakFast)
                let nav = MainNavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.tabBarController?.present(nav, animated: true, completion: nil)
            case "lunch":
                vc = AddViewController(type: .Launch)
                let nav = MainNavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.tabBarController?.present(nav, animated: true, completion: nil)
            case "dinner":
                vc = AddViewController(type: .Dinner)
                let nav = MainNavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.tabBarController?.present(nav, animated: true, completion: nil)
            case "refreshments":
                vc = AddViewController(type: .Snacks)
                let nav = MainNavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.tabBarController?.present(nav, animated: true, completion: nil)
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
    
    private lazy var centerView:CenterUIView = {
        let vi = CenterUIView()
        return vi
    }()
    
    private lazy var circleView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = CGSize(width: 0, height: -3.fit)
        backView.layer.shadowOpacity = 0.2
        return backView
    }()
    
    private lazy var coverView: UIView = {
        let vi = UIView()
        vi.backgroundColor = .white
        return vi
    }()
    
    // 相机
    private lazy var camera: DKCamera = {
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
    
    // MARK: - 公有方法
    
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
    
    // MARK: - 私有方法
    
    private func configUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        self.collectionView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalToSuperview()
            make.top.equalTo(self.navigation.bar.snp.top).offset(0.fit)
        }
    }
    
    private func configNavbar() {
        self.navigation.bar.isHidden = true
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
    }
    
    private func configCenterButton() {
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
        centerView.addSubview(fanMenu)
        fanMenu.snp.makeConstraints { (make) in
            make.centerX.equalTo(centerView.snp.centerX)
            make.centerY.equalTo(centerView.snp.top).offset(0.fit)
            make.height.equalTo(value*3)
            make.width.equalTo(CFWidth/2)
        }
    }
    
    func configTabbar() {
        
    }
    
    func configData() {
        //1 获取json文件路径
        let path = Bundle.main.path(forResource: "homelist", ofType: "json")
        //2 获取json文件里面的内容,NSData格式
        let jsonData = NSData(contentsOfFile: path!)
        //3 解析json内容
        let json = JSON(jsonData!)
        homeData = JSONDeserializer<DataClass>.deserializeFrom(json: json["data"].description)!
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
            cell.searchBarCallBack = { ()
                let vc = RecognizeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.photoCallBack = { ()
                self.present(self.camera, animated: true, completion: nil)
            }
            cell.eatCallBack = { (type) in
                // 回调TODO：
                switch type {
                case .BreakFast:
                    let vc = RecipeViewController()
                    vc.updateUI(with: self.homeData.mealdetail)
                    self.navigationController?.pushViewController(vc, animated: true)
                default:
                    break;
                }
            }
            cell.updateUI(with: homeData.eats)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayRecommendCollectionViewCellID, for: indexPath) as! DayRecommendCollectionViewCell
            
            cell.moreButtonBlock = { ()
                let vc = DayRecommendViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.cellCallBack = { (data) in
                let vc = RecipeDetailViewController(data: data)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.updateUI(with: homeData.dayRecommend)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SupplementCollectionViewCellID, for: indexPath) as! SupplementCollectionViewCell
            
            cell.moreButtonBlock = { ()
                let vc = SupplementViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.cellCallBack = { (data) in
                let vc = RecipeDetailViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.updateUI(with: homeData.paln)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestCollectionViewCellID, for: indexPath) as! SuggestCollectionViewCell
            
            cell.moreButtonBlock = { ()
                let vc = FavViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.cellCallBack = { (data) in
                let vc = RecipeDetailViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.updateUI(with: homeData.suggest)
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavCollectionViewCellID, for: indexPath) as! FavCollectionViewCell
            cell.updateUI(with: homeData.fav)
            cell.moreButtonBlock = { ()
                let vc = FavViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.cellCallBack = { (data) in
                let vc = RecipeDetailViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
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
            return CGSize(width: CFWidth, height: 175.fit)
        case 1:
            return CGSize(width: CFWidth, height: 300.fit)
        case 2:
            return CGSize(width: CFWidth, height: 310.fit)
        case 3:
            return CGSize(width: CFWidth, height: 275.fit)
        case 4:
            return CGSize(width: CFWidth, height: 230.fit)
        default: 
            return CGSize(width: CFWidth, height: 0)
        }
        
    }
    
    // 头部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderViewID, for: indexPath) as? HomeHeaderView else {
            return UICollectionReusableView()
        }
        headerView.backgroundColor = UIColor(red: 0.99, green: 0.98, blue: 0.98, alpha: 1)
        return headerView
    }
    
    // 头部高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: CFWidth, height: 0)
        }
        return CGSize(width: CFWidth, height: 15.fit)
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.fit, left: 0, bottom: 15.fit, right: 0)
        
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.fit
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.fit
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

