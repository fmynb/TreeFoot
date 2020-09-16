//
//  RecoderViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/15.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

// MARK:  Register cellID
fileprivate let TopTotalCollectionViewCellID = "TopTotalCollectionViewCell"
fileprivate let ToDayInCollectionViewCellID = "ToDayInCollectionViewCell"
fileprivate let RecoderHeaderViewID = "RecoderHeaderView"
fileprivate let WaterInCollectionViewCellID = "WaterInCollectionViewCell"
fileprivate let SuggestCollectionViewCellID = "SuggestCollectionViewCell"
fileprivate let FavCollectionViewCellID = "FavCollectionViewCell"


class RecoderViewController: UIViewController {

    // 左边按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mine_icon_set")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.black
        button.tintColor = UIColor.black
        button.setImage(imageView.image, for: .normal)
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        button.addTarget(self, action: #selector(calendarClick), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    @objc func calendarClick() {
        let calendarVC = CalendarViewController()
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
    
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
    
    private lazy var titleView: RecoderBarView = {
        let view = RecoderBarView()
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
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints{ (make) in
             make.left.equalTo(self.view.snp.left).offset(0)
             make.right.equalTo(self.view.snp.right).offset(0)
             make.bottom.equalToSuperview()
            make.top.equalTo(self.navigation.bar.snp.bottom).offset(0.fit)
         }
    }
    
    func configNavbar() {
        self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigation.item.titleView = self.titleView
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 1
    }

}


extension RecoderViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTotalCollectionViewCellID, for: indexPath) as! TopTotalCollectionViewCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDayInCollectionViewCellID, for: indexPath) as! ToDayInCollectionViewCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterInCollectionViewCellID, for: indexPath) as! WaterInCollectionViewCell
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
            return CGSize(width: CFWidth, height: 220.fit)
        case 1:
            return CGSize(width: CFWidth, height: 310.fit)
        case 2:
            return CGSize(width: CFWidth, height: 200.fit)
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
