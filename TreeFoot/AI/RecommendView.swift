//
//  RecommendView.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/23.
//  Copyright © 2020 Hut. All rights reserved.
//

import Foundation
import UIKit

class RecommendView: UIView {
    
    lazy var materialslabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "用料：牛油果、鸡蛋、青菜、山楂")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 10)!,.foregroundColor: UIColor(red: 0.71, green: 0.68, blue: 0.68,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1;
        return label
    }()//原料内容
    
    lazy var namelabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "素食拼盘")
        label.numberOfLines = 2
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 13)!,.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()//菜品名字
    
    lazy var contentimage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "素食拼盘")
        return imageview
    }()//菜品图片
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
                // shadowCode
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 1
        layer.shadowRadius = 6
        // fill
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 8;
        // alpha = 0.35
        
        self.addSubview(contentimage)
        self.addSubview(namelabel)
        self.addSubview(materialslabel)
        self.contentimage.snp.makeConstraints{ (make) in
            make.height.equalTo(164.fit)
            make.width.equalTo(153.fit)
            make.left.equalToSuperview().offset(0.fit)
            make.top.equalToSuperview().offset(0.fit)
        }
        self.materialslabel.snp.makeConstraints{ (make) in
            make.height.equalTo(32.fit)
            make.width.equalTo(122.fit)
            make.left.equalToSuperview().offset(13.fit)
            make.top.equalToSuperview().offset(197.fit)
        }
        self.namelabel.snp.makeConstraints{ (make) in
            make.height.equalTo(18.fit)
            make.width.equalTo(60.fit)
            make.left.equalToSuperview().offset(13.fit)
            make.top.equalToSuperview().offset(175.fit)
        }
    }
    
}
