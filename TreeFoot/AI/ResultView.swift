//
//  ResultView.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/23.
//  Copyright © 2020 Hut. All rights reserved.
//

import Foundation
import UIKit

class ResultView: UIView {
    
    var resultLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.init(name: "PingFangSC-Semibold", size: 24.fit)
            label.textColor = UIColor.init(r: 56, g: 56, b: 56 )
            label.text = "牛果油"
            return label
        }()
        
        // 结果set
        lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            layout.scrollDirection = .horizontal
            
    //        collectionView.backgroundColor = .clear
    //        collectionView.dataSource = self
    //        collectionView.showsHorizontalScrollIndicator = false//隐藏滑动条
    //        collectionView.alwaysBounceHorizontal = true
    //        collectionView.delegate = self
            //collectionView.register(searchCell.classForCoder(), forCellWithReuseIdentifier: searchId)
            return collectionView
        }()
        
        var descretionLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.init(name: "PingFangSC-Semibold", size: 24.fit)
            label.textColor = UIColor.init(r: 56, g: 56, b: 56 )
            label.text = "牛油果是一种营养价值很高的水果，含多种维生素 丰富的脂肪和蛋白质，钠、钾、镁、钙等含量也高 除作生果食用外也可作菜肴和罐头；果仁含脂肪油 为非干性油， 有温和的香气 ，比重0.9132，皂化 值192.6，非皂化物1.6%，供食用、医药和化妆工 业用。"
            label.numberOfLines = 0
            return label
        }()
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
    }
    
}
