//
//  IngredientsTableViewCell.swift
//  TreeFoot
//
//  Created by Ryan on 2020/10/12.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    // MARK: - 公有属性
    
    //    public var minusButtonBlock: (() -> ())?
    //
    //    public var addButtonBlock: (() -> ())?
    
    // MARK: - 私有属性
    
    private lazy var backView: UIView = {
        let layerView = UIView()
        // shadowCode
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 6
        // fill
        layerView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        layerView.layer.cornerRadius = 14;
        layerView.alpha = 1
        return layerView
    }()
    
    // 左图
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FavCollectionViewCell-1")
        return imageView
    }()
    
    // 内容
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "生鸡蛋(两个)")
        label.numberOfLines = 0
        label.textAlignment = .left
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Light", size: 15)!,.foregroundColor: UIColor(red: 0.24, green: 0.24, blue: 0.24,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
    
    //    // 减按钮
    //    private lazy var minusButton: UIButton = {
    //        let button = UIButton()
    //        button.addTarget(self, action: #selector(clickMinusButton), for: .touchUpInside)
    //        return button
    //    }()
    //
    //    private lazy var minusButtonImageView: UIImageView = {
    //        let imageView = UIImageView()
    //        imageView.image = UIImage(named: "minus")
    //        return imageView
    //    }()
    //
    //    // 加按钮
    //    private lazy var addButton: UIButton = {
    //        let button = UIButton()
    //        button.addTarget(self, action: #selector(clickAddButton), for: .touchUpInside)
    //        return button
    //    }()
    //
    //    private lazy var addButtonImageView: UIImageView = {
    //        let imageView = UIImageView()
    //        imageView.image = UIImage(named: "add_")
    //        return imageView
    //    }()
    //
    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backColor")
        return imageView
    }()
    //
    // 用量
    private lazy var useLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "50g")
        label.numberOfLines = 0
        label.textAlignment = .center
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 16)!,.foregroundColor: UIColor(red: 0.23, green: 0.23, blue: 0.23,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
    
    // MARK: - 公有方法
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateUI(_ data: Ingredient) {
        leftImageView.image = UIImage(named: data.image)
        nameLabel.text = data.name
        useLabel.text = data.dosage
    }
    
    // MARK: - 私有方法
    
    private func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(backView)
        backView.addSubview(leftImageView)
        backView.addSubview(nameLabel)
        backView.addSubview(backImageView)
        backImageView.addSubview(useLabel)
        //        backView.addSubview(minusButtonImageView)
        //        backView.addSubview(minusButton)
        //        backView.addSubview(addButtonImageView)
        //        backView.addSubview(addButton)
        //        backView.addSubview(backCalorisImageView)
        //        backView.addSubview(calorisLabel)
        
        backView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24.fit)
            make.right.equalToSuperview().offset(-24.fit)
            make.bottom.equalToSuperview().offset(-18.fit)
            make.top.equalToSuperview()
        }
        
        leftImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(62.fit)
            make.left.equalToSuperview().offset(14.fit)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.leftImageView.snp.right).offset(10.fit)
            make.width.equalTo(100.fit)
            make.height.equalTo(30.fit)
        }
        
        backImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20.fit)
            make.width.equalTo(100.fit)
            make.centerY.equalToSuperview()
            make.height.equalTo(30.fit)
        }
        
        useLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        //        addButtonImageView.snp.makeConstraints { (make) in
        //            make.right.equalToSuperview().offset(-14.fit)
        //            make.centerY.equalToSuperview()
        //            make.width.equalTo(16.fit)
        //            make.height.equalTo(19.fit)
        //        }
        //
        //        addButton.snp.makeConstraints { (make) in
        //            make.right.equalToSuperview().offset(-14.fit)
        //            make.centerY.equalToSuperview()
        //            make.width.equalTo(16.fit)
        //            make.height.equalTo(19.fit)
        //        }
        //
        //        minusButtonImageView.snp.makeConstraints { (make) in
        //            make.right.equalTo(self.addButton.snp.left).offset(-70.fit)
        //            make.centerY.equalToSuperview()
        //            make.width.equalTo(16.fit)
        //            make.height.equalTo(19.fit)
        //        }
        //
        //        minusButton.snp.makeConstraints { (make) in
        //            make.right.equalTo(self.addButton.snp.left).offset(-70.fit)
        //            make.centerY.equalToSuperview()
        //            make.width.equalTo(16.fit)
        //            make.height.equalTo(19.fit)
        //        }
        //
        //        backCalorisImageView.snp.makeConstraints { (make) in
        //            make.right.equalTo(self.addButton.snp.left).offset(-5.fit)
        //            make.left.equalTo(self.minusButton.snp.right).offset(5.fit)
        //            make.centerY.equalToSuperview()
        //            make.height.equalTo(30.fit)
        //        }
        //
        //        calorisLabel.snp.makeConstraints { (make) in
        //            make.right.equalTo(self.addButton.snp.left).offset(-5.fit)
        //            make.left.equalTo(self.minusButton.snp.right).offset(5.fit)
        //            make.centerY.equalToSuperview()
        //            make.height.equalTo(30.fit)
        //        }
    }
    
    //    @objc private func clickMinusButton() {
    //        minusButtonBlock?()
    //    }
    //
    //    @objc private func clickAddButton() {
    //        addButtonBlock?()
    //    }
}

