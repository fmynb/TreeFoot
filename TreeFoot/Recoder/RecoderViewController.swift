//
//  RecoderViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/15.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
// MARK:  Register cellID
fileprivate let TopTotalCollectionViewCellID = "TopTotalCollectionViewCell"
fileprivate let ToDayInCollectionViewCellID = "ToDayInCollectionViewCell"
fileprivate let RecoderHeaderViewID = "RecoderHeaderView"
fileprivate let WaterInCollectionViewCellID = "WaterInCollectionViewCell"
fileprivate let SuggestCollectionViewCellID = "SuggestCollectionViewCell"
fileprivate let FavCollectionViewCellID = "FavCollectionViewCell"


class RecoderViewController: UIViewController {
    // 之前数据索引
    var index = -1
    var recorderData = RecoderDataClass()
    var datas = Today()
    // 左边按钮
    private lazy var leftBarButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mine_icon_set")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.black
        button.tintColor = UIColor.black
        button.setImage(imageView.image, for: .normal)
        button.addTarget(self, action: #selector(calendarClick), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    private var typeArray = [IntakeOfType.BreakFast, .Launch, .Dinner, .Snacks]
    
    @objc func calendarClick() {
        let calendarVC = CalendarViewController()
        self.navigationController?.pushViewController(calendarVC, animated: true)
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
    
    private lazy var titleView: RecoderBarView = {
        let view = RecoderBarView(frame: CGRect(x: 0, y: 0, width: CFWidth, height: kNavBarHeight))
        view.clickAddButtonBlock = {
              let calendarVC = CalendarViewController()
            self.navigationController?.pushViewController(calendarVC, animated: true)
        }
        view.clickCalendarButtonBlock = {
            print("calendar")
            
        }
        view.clickRightArrowButtonBlock = {
            print("rightArrow")
            guard self.index > -1 else {
                return
            }
            view.showLeftButton()
            self.index -= 1
            guard self.index != -1 else {
                self.updateUI(with: self.recorderData.today)
                view.hiddenRightButton()
                return
            }
             
            self.updateUI(with: self.recorderData.old_datas[self.index])

        }
        view.clickLeftArrowButtonBlock = {
            print("leftArrow")
            guard self.index < self.recorderData.old_datas.count - 1 else {
                
                return
            }
            view.showRightButton()
            self.index += 1
            self.updateUI(with: self.recorderData.old_datas[self.index])
            if self.index == self.recorderData.old_datas.count - 1  {
                view.hiddenLeftButton()
            }

        }
        view.hiddenRightButton()
        return view
    }()
    
    // 主界面控件
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        
        // 注册cell
        collection.register(TopTotalCollectionViewCell.self, forCellWithReuseIdentifier: TopTotalCollectionViewCellID)
        collection.register(ToDayInCollectionViewCell.self, forCellWithReuseIdentifier: ToDayInCollectionViewCellID)
        collection.register(WaterInCollectionViewCell.self, forCellWithReuseIdentifier: WaterInCollectionViewCellID)
        
        collection.register(RecoderHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecoderHeaderViewID)
        
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
        configData()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
             make.left.equalTo(self.view.snp.left).offset(0)
             make.right.equalTo(self.view.snp.right).offset(0)
             make.bottom.equalToSuperview()
             make.top.equalTo(self.navigation.bar.snp.bottom).offset(0.fit)
         }
    }
    
    func configNavbar() {
//        self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
//        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigation.item.titleView = self.titleView
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 1
    }
    
    func configData() {
        //1 获取json文件路径
               let path = Bundle.main.path(forResource: "recorder", ofType: "json")
               //2 获取json文件里面的内容,NSData格式
               let jsonData=NSData(contentsOfFile: path!)
               //3 解析json内容
               let json = JSON(jsonData!)
        print(json)
               recorderData = JSONDeserializer<RecoderDataClass>.deserializeFrom(json: json["data"].description)!
        print(recorderData)
        self.updateUI(with: recorderData.today)
    }
    
    func updateUI(with data:Today) {
        self.datas = data
        self.titleView.updateTilte(with: self.datas.time)
        self.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

}


extension RecoderViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTotalCollectionViewCellID, for: indexPath) as! TopTotalCollectionViewCell
           // cell.updateUI(weight: 100, calories: 80, percent: 80)
            cell.updateUI(weight: Int(datas.body.weight), calories: Int(datas.body.attract), percent: Int(datas.body.rest))
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDayInCollectionViewCellID, for: indexPath) as! ToDayInCollectionViewCell
            let instance = AddMune.getSharedInstance()
            cell.setType(type: typeArray[indexPath.row])
            cell.updateUI(instance.imageNames[indexPath.row].first)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterInCollectionViewCellID, for: indexPath) as! WaterInCollectionViewCell
            //cell.updateUI(target: 8.0, accomplish: 3.0)
            cell.updateUI(target:CGFloat(datas.water_attract.target) , accomplish: CGFloat(datas.water_attract.attracted))
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTotalCollectionViewCellID, for: indexPath) as! TopTotalCollectionViewCell
            return cell
        }

    }
    
    
}

extension RecoderViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: CFWidth, height: 190.fit)
        case 1:
            return CGSize(width: 194.fit, height: 140.fit)
        case 2:
            return CGSize(width: CFWidth, height: 150.fit)
        case 3:
            return CGSize(width: CFWidth, height: 280.fit)
        case 4:
            return CGSize(width: CFWidth, height: 250.fit)
        default:
             return CGSize(width: CFWidth, height: 0)
        }
            
    }
    
    // 头部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecoderHeaderViewID, for: indexPath) as? RecoderHeaderView else {
            return UICollectionReusableView()
        }
        if indexPath.section == 1 {
            headerView.titleLabel.text = "今日摄入"
        }else if indexPath.section == 2 {
            headerView.titleLabel.text = "水分摄入"
        }
        headerView.backgroundColor = .clear
        return headerView
    }
    // 头部高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: CFWidth, height: 0)
        }else if section == 1 {
            return CGSize(width: CFWidth, height: 25.fit)
        }else if section == 2 {
            return CGSize(width: CFWidth, height: 25.fit)
        }
        return CGSize(width: CFWidth, height: 10.fit)
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 10.fit, left: 0.fit, bottom: 10.fit, right: 0.fit)
        case 1:
            return UIEdgeInsets(top: 10.fit, left: 20.fit, bottom: 10.fit, right: 0)
        case 2:
            return UIEdgeInsets(top: 10.fit, left: 0.fit, bottom: 10.fit, right: 0.fit)
        default:
            return UIEdgeInsets(top: 10.fit, left: 0.fit, bottom: 10.fit, right: 0.fit)
        }
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 0.fit
        }
        return 10.fit
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.fit
    }
}
