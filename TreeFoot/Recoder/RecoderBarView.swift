//
//  RecoderBarView.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class RecoderBarView: UIView {

    public var clickLeftArrowButtonBlock: (() -> ())?
    
    public var clickRightArrowButtonBlock: (() -> ())?
    
    public var clickCalendarButtonBlock: (() -> ())?
    
    public var clickAddButtonBlock: (() -> ())?

    // 右部添加按钮
    private lazy var rightAddButton: UIButton = {
        let button = UIButton(frame: CGRect(x: CFWidth - 54.fit, y: kNavBarHeight / 2 - 12.fit, width: 22.fit, height: 22.fit))
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(clickAddButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: CFWidth - 54.fit, y: kNavBarHeight / 2 - 12.fit, width: 22.fit, height: 22.fit))
        imageView.image = UIImage(named: "calendar");
        return imageView
    }()
    
    // 左箭头按钮
    private lazy var leftArrowButton: UIButton = {
        let button = UIButton(frame: CGRect(x: CFWidth / 2 - 86.fit, y: kNavBarHeight / 2 - 8.fit, width: 16.fit, height: 16.fit))
        button.setTitle("<", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(clickLeftArrowButton), for: .touchUpInside)
        return button
    }()
    
    // 右箭头按钮
    private lazy var rightArrowButton: UIButton = {
        let button = UIButton(frame: CGRect(x: CFWidth / 2 + 70.fit, y: kNavBarHeight / 2 - 8.fit, width: 10.fit, height: 16.fit))
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(clickRightArrowButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightArrowImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: CFWidth / 2 + 70.fit, y: kNavBarHeight / 2 - 8.fit, width: 10.fit, height: 16.fit))
        imageView.image = UIImage(named: "rightArrow")
        return imageView
    }()
    
    // 日期标签
    private lazy var dateTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: CFWidth / 2 - 40.fit, y: kNavBarHeight / 2 - 15.fit, width: 80.fit, height: 30.fit))
        let attrString = NSMutableAttributedString(string: "5月13日")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 17)!,.foregroundColor: UIColor(red: 0.26, green: 0.26, blue: 0.26,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.textAlignment = .center
        label.alpha = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(calendarImageView)
        addSubview(dateTitleLabel)
        addSubview(rightAddButton)
        addSubview(leftArrowButton)
        addSubview(rightArrowImageView)
        addSubview(rightArrowButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func hiddenRightButton(){
        self.rightArrowButton.isHidden = true
    }
    public func hiddenLeftButton(){
        self.leftArrowButton.isHidden = true
    }
    public func showRightButton(){
        self.rightArrowButton.isHidden = false
    }
    public func showLeftButton(){
        self.leftArrowButton.isHidden = false
    }
    
    public func updateTilte(with text:String) {
        let attrString = NSMutableAttributedString(string: text)
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 17)!,.foregroundColor: UIColor(red: 0.26, green: 0.26, blue: 0.26,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        dateTitleLabel.attributedText = attrString
    }
    // 点击事件
    
    @objc func clickLeftArrowButton() {
        clickLeftArrowButtonBlock?()
    }
    
    @objc func clickRightArrowButton() {
        clickRightArrowButtonBlock?()
    }
    
    @objc func clickCalendarButton() {
        clickCalendarButtonBlock?()
    }
    
    @objc func clickAddButton() {
        clickAddButtonBlock?()
    }
}
