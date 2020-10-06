//
//  HomeBaseCollectionViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit


let TopSpacing = 14.fit

// TODO 基础Cell
class HomeBaseCollectionViewCell: UICollectionViewCell {
    
    var titleText = ""
    // 更新title
    public func updateUI(with text: String) {
        self.titleLabel.text = text
    }
    
    // 更多按钮回调
    public var moreButtonBlock: (() -> ())?
    
    
    // 标题
     var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 20.fit)
        label.textColor = UIColor.init(r: 56, g: 56, b: 56 )
        
        return label
    }()
    
    lazy var moreBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(more), for: .touchUpInside)
        btn.alpha = 0
        return btn
    }()
    
    lazy var moreLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "更多")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Light", size: 15)!,.foregroundColor: UIColor(red: 0.98, green: 0.59, blue: 0.48, alpha: 1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    lazy var moreImageView: UIView = {
        let image = UIImage(systemName: "chevron.right")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 15, weight: .bold))
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor(red: 0.98, green: 0.59, blue: 0.48, alpha: 1)
        return imageView
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
    
    func setUpUI() {
        
        addSubview(titleLabel)
        addSubview(moreLabel)
        addSubview(moreBtn)
        addSubview(moreImageView)
        
        moreLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(TopSpacing)
            make.width.equalTo(30.fit)
            make.height.equalTo(28.fit)
            make.right.equalToSuperview().offset(-30.fit)
        }
        
        titleLabel.snp.makeConstraints{ (make) in
            make.height.equalTo(28.fit)
            make.width.equalTo(200.fit)
            make.left.equalToSuperview().offset(15.fit)
            make.top.equalToSuperview().offset(TopSpacing)
        }
        
        moreImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(18.fit)
            make.width.equalTo(16.fit)
            make.height.equalTo(16.fit)
            make.right.equalToSuperview().offset(-12.fit)
        }
        
        moreBtn.snp.makeConstraints{ (make) in
            make.height.equalTo(28.fit)
            make.width.equalTo(40.fit)
            make.right.equalToSuperview().offset(-12.fit)
            make.top.equalToSuperview().offset(TopSpacing)
        }
    }
}
