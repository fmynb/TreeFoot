//
//  HomeViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/15.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit


// MARK:  Register cellID
fileprivate let SearchCollectionViewCellID = "SearchCollectionViewCell"
fileprivate let DayRecommendCollectionViewCellID = "DayRecommendCollectionViewCell"
fileprivate let HomeHeaderViewID = "HomeHeaderView"
fileprivate let SupplementCollectionViewCellID = "SupplementCollectionViewCell"
fileprivate let SuggestCollectionViewCellID = "SuggestCollectionViewCell"
fileprivate let FavCollectionViewCellID = "FavCollectionViewCell"


class HomeViewController: UIViewController {

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
            make.top.equalTo(self.navigation.bar.snp.top).offset(0.fit)
         }
    }
    
    func configNavbar() {
        self.navigation.bar.isHidden = true
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayRecommendCollectionViewCellID, for: indexPath) as! DayRecommendCollectionViewCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SupplementCollectionViewCellID, for: indexPath) as! SupplementCollectionViewCell
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestCollectionViewCellID, for: indexPath) as! SuggestCollectionViewCell
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavCollectionViewCellID, for: indexPath) as! FavCollectionViewCell
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
            return CGSize(width: CFWidth, height: 280.fit)
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
