//
//  HomeBaseCollectionViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

// TODO 基础Cell
class HomeBaseCollectionViewCell: UICollectionViewCell {
    
    // 更新title
    public func updateUI(with text: String) {
        self.titleLabel.text = text
    }
    
    // 更多按钮回调
    public var moreButtonBlock: (() -> ())?
    
    
    // 标题
     var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 24.fit)
        label.textColor = UIColor.init(r: 56, g: 56, b: 56 )
        
        return label
    }()
    
    lazy var moreBtn:UIButton = {
       let btn = UIButton()
        btn.setTitle("更多", for: .normal)
        btn.titleLabel?.font = UIFont.init(name: "PingFangSC-Medium", size: 14.fit)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "right_icon")?.withRenderingMode(.alwaysTemplate)
       // imageView.contentMode = .scaleAspectFit
        btn.setImage(imageView.image, for: .normal)
        btn.tintColor = UIColor.init(r: 96, g: 114, b: 255)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(more), for: .touchUpInside)
        return btn
    }()
    
    @objc func more() {
        if let block = self.moreButtonBlock {
            block()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        self.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(20.fit)
            make.width.equalTo(300.fit)
            make.height.equalTo(30.fit)
        }
    }
}
