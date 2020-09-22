//
//  ToDayInCollectionViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

enum IntakeOfType: Int {
    case BreakFast = 0
    case Launch
    case Dinner
    case Snacks
}

func getIntakeOfTypeString(_ type: IntakeOfType) -> String {
    switch type {
    case .BreakFast:
        return "早餐"
    case .Launch:
        return "午餐"
    case .Dinner:
        return "晚餐"
    case .Snacks:
        return "零食"
    }
}

// TODO 今日摄入Cell
class ToDayInCollectionViewCell: UICollectionViewCell {
    // MARK: - 私有属性
    
    private var intakeType: IntakeOfType = .BreakFast
    
    private lazy var backView: UIView = {
        let view = UIView()
        // shadowCode
        view.layer.shadowColor = UIColor(red: 0.35, green: 0.15, blue: 0, alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        // fill
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 10
        view.alpha = 1
        return view
    }()
    
    // 添加按钮
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(red: 1, green: 0.68, blue: 0.5, alpha: 1)
        button.addTarget(self, action: #selector(clickAddButton), for: .touchUpInside)
        button.layer.cornerRadius = 20.fit
        return button
    }()
    
    // 添加标签
    private lazy var addLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "添加")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 12)!,.foregroundColor: UIColor(red: 0.26, green: 0.26, blue: 0.26,alpha:1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1;
        return label
    }()
    
    // 类型标签
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: getIntakeOfTypeString(self.intakeType))
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 13)!,.foregroundColor: UIColor(red: 1, green: 0.46, blue: 0.29,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.textAlignment = .center
        return label
    }()
    
    // 左上标视图
    private lazy var leftTopView: UIView = {
        let layerView = UIView()
        // strokeCode
        layerView.layer.borderColor = UIColor(red: 1, green: 0.46, blue: 0.29, alpha: 1).cgColor
        layerView.layer.borderWidth = 1
        layerView.layer.cornerRadius = 10
        layerView.layer.masksToBounds = true
        layerView.alpha = 1
        layerView.addSubview(self.typeLabel)
        self.typeLabel.snp.makeConstraints { (make) in
            make.width.equalTo(36.fit)
            make.height.equalTo(26.fit)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        return layerView
    }()
    
    // MARK: - 公有方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    /// 设置餐食类型
    /// - Parameter type: 类型
    public func setType(type: IntakeOfType) {
        self.intakeType = type
        let attrString = NSMutableAttributedString(string: getIntakeOfTypeString(self.intakeType))
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 13)!,.foregroundColor: UIColor(red: 1, green: 0.46, blue: 0.29,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        self.typeLabel.attributedText = attrString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 私有方法
    
    private func setUpUI() {
        addSubview(backView)
        backView.addSubview(leftTopView)
        backView.addSubview(addButton)
        backView.addSubview(addLabel)
        
        leftTopView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(44.fit)
            make.height.equalTo(34.fit)
        }
        
        backView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)//.offset(20.fit)
            make.right.equalTo(self.snp.right).offset(-20.fit)
            make.top.equalToSuperview().offset(5.fit)
            make.bottom.equalToSuperview().offset(-5.fit)
        }
        
        addButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40.fit)
        }
        
        addLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.addButton.snp.bottom).offset(10.fit)
            make.centerX.equalToSuperview()
            make.width.equalTo(28.fit)
            make.height.equalTo(20.fit)
        }
    }
    
    @objc func clickAddButton() {
        // TODO: - 按钮点击事件
        let vc = ViewController()
    }
}
