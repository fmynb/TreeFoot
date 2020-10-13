//
//  CalorisTotalTableViewCell.swift
//  TreeFoot
//
//  Created by Ryan on 2020/10/12.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class CalorisTotalTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(totalLabel)
        addSubview(calorisBackImageView)
        calorisBackImageView.addSubview(calorisNumberLabel)
        calorisBackImageView.addSubview(calorisUnitLabel)
        
        calorisBackImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-30.fit)
            make.top.equalToSuperview().offset(10.fit)
            make.width.equalTo(113.fit)
            make.height.equalTo(55.fit)
        }
        
        calorisNumberLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15.fit)
            make.width.equalTo(50.fit)
            make.height.equalTo(30.fit)
        }
        
        calorisUnitLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20.fit)
            make.centerY.equalToSuperview().offset(2.fit)
            make.width.equalTo(30.fit)
            make.height.equalTo(20.fit)
        }
        
        totalLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.calorisBackImageView.snp.left).offset(-8.fit)
            make.width.equalTo(35.fit)
            make.height.equalTo(20.fit)
            make.bottom.equalTo(self.calorisBackImageView.snp.bottom).offset(-5.fit)
        }
    }

    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "合计")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 15)!,.foregroundColor: UIColor(red: 0.24, green: 0.24, blue: 0.24,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
    
    private lazy var calorisBackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sumRectangle")
        return imageView
    }()
    
    private lazy var calorisNumberLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "200")
        label.numberOfLines = 0
        label.textAlignment = .center
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 18)!,.foregroundColor: UIColor(red: 1, green: 1, blue: 1,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
    
    private lazy var calorisUnitLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "千卡")
        label.numberOfLines = 0
        label.textAlignment = .left
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 12)!,.foregroundColor: UIColor(red: 1, green: 1, blue: 1,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
}
