//
//  SearchCollectionViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
import SnapKit

// TODO: 顶部搜索+左右列表滑动
class SearchCollectionViewCell: UICollectionViewCell {
    // 背景
    lazy var backView:UIView = {
       let vi = UIView()

        vi.layer.cornerRadius = 15.fit
        return vi
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        configShadow()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI(){
        self.backgroundColor = .red
        addSubview(backView)

        
        backView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(20.fit)
            make.right.equalTo(self).offset(-20.fit)
            make.centerY.equalTo(self)
            make.height.equalTo(150.fit)
        }
        
        
        
        
    }
    
    private func configShadow(){
        self.backView.backgroundColor = .white
        self.backView.layer.cornerRadius = 15.fit
        self.backView.layer.masksToBounds = false
        self.backView.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        self.backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        self.backView.layer.shadowOpacity = 1
        self.backView.layer.shadowRadius = 12.fit
    }
    
}
