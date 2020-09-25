//
//  AddArletView.swift
//  TreeFoot
//
//  Created by 欧阳子谦 on 9/25/20.
//  Copyright © 2020 Hut. All rights reserved.
//

import Foundation
import UIKit

class AddArletView: UIView {
    
    lazy var AddTobreakfast: UIButton = {
        let button = UIButton(type:.system)
        button.layer.cornerRadius = 21
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
        button.layer.masksToBounds = true
        button.setTitle("早餐", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.colorWithHex(hexStr: "#AFABAB", alpha: 1), for: .normal)

        button.addTarget(self, action: #selector(BoardToorange(_:)), for: .touchUpInside)
        
        return button
    }()//早餐按钮
    
    private var index = 0
    
    lazy var AddTolunch: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("午餐", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 21
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(BoardToorange(_:)), for: .touchUpInside)
        button.setTitleColor(UIColor.colorWithHex(hexStr: "#AFABAB", alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(BoardToorange(_:)), for: .touchUpInside)
        return button
    }()//午餐按钮
    
    lazy var AddTosupper: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("晚餐", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 21
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.colorWithHex(hexStr: "#AFABAB", alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(BoardToorange(_:)), for: .touchUpInside)
        return button
    }()//晚餐按钮
    
    lazy var AddTosnacks: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("小食", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 21
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.colorWithHex(hexStr: "#AFABAB", alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(BoardToorange(_:)), for: .touchUpInside)
        return button
    }()//小食按钮
    
    lazy var AddTocentern: UIButton = {
        let button = UIButton()
        button.setTitle("添加",for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 21
        button.layer.borderWidth = 0.5
        button.backgroundColor = .orange
        button.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(BoardToorange(_:)), for: .touchUpInside)
        return button
    }()//添加按钮
    
    lazy var AddTotext: UILabel = {
        let label = UILabel()
        label.text = "添加至"
        label.font = UIFont.systemFont(ofSize: 25.fit)//UIFont(name: , size: 77)
        return label
    }()//添加至文本
    
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.addSubview(AddTobreakfast)
        self.addSubview(AddTolunch)
        self.addSubview(AddTosupper)
        self.addSubview(AddTosnacks)
        self.addSubview(AddTotext)
        self.addSubview(AddTocentern)
        self.AddTobreakfast.snp.makeConstraints{ (make) in
            make.height.equalTo(33.fit)
            make.width.equalTo(93.fit)
            make.left.equalToSuperview().offset(38.fit)
            make.top.equalToSuperview().offset(98.fit)
        }
        self.AddTolunch.snp.makeConstraints{ (make) in
            make.height.equalTo(33.fit)
            make.width.equalTo(93.fit)
            make.left.equalToSuperview().offset(172.fit)
            make.top.equalToSuperview().offset(98.fit)
        }
        self.AddTosupper.snp.makeConstraints{ (make) in
            make.height.equalTo(33.fit)
            make.width.equalTo(93.fit)
            make.left.equalToSuperview().offset(38.fit)
            make.top.equalToSuperview().offset(158.fit)
        }
        self.AddTosnacks.snp.makeConstraints{ (make) in
            make.height.equalTo(33.fit)
            make.width.equalTo(93.fit)
            make.left.equalToSuperview().offset(172.fit)
            make.top.equalToSuperview().offset(158.fit)
        }
        self.AddTotext.snp.makeConstraints{ (make)in
            make.height.equalTo(36.fit)
            make.width.equalTo(77.fit)
            //make.left.equalToSuperview().offset(130.fit)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(33.fit)
        }
        self.AddTocentern.snp.makeConstraints{ (make)in
            make.height.equalTo(42.fit)
            make.width.equalTo(206.fit)
            //make.left.equalToSuperview().offset(130.fit)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(220.fit)
            
        }
    }
    @objc func BoardToorange(_ sender: UIButton) {
        if sender === AddTobreakfast {
            sender.layer.borderColor = UIColor.colorWithHex(hexStr: "#FF6600", alpha: 1).cgColor
            self.AddTolunch.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
            self.AddTosupper.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
            self.AddTosnacks.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
            
        } else if sender == AddTolunch {
            sender.layer.borderColor = UIColor.colorWithHex(hexStr: "#FF6600", alpha: 1).cgColor
            self.AddTobreakfast.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
            self.AddTosupper.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
            self.AddTosnacks.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
        }else if sender == AddTosupper{
            sender.layer.borderColor = UIColor.colorWithHex(hexStr: "#FF6600", alpha: 1).cgColor
            self.AddTobreakfast.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
            self.AddTolunch.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
            self.AddTosnacks.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
        }else if sender == AddTosnacks{
            sender.layer.borderColor = UIColor.colorWithHex(hexStr: "#FF6600", alpha: 1).cgColor
            self.AddTobreakfast.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
            self.AddTolunch.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
            self.AddTosupper.layer.borderColor = UIColor.colorWithHex(hexStr: "#D1CCCC", alpha: 1).cgColor
        }
    }
    
}


extension UIColor{
    class func colorWithHex(hexStr:String, alpha:Float) -> UIColor{
        var cStr = hexStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        
        if(cStr.length < 6){
            return UIColor.clear;
        }
        
        if(cStr.hasPrefix("0x")) {
            cStr = cStr.substring(from: 2) as NSString
        }
        
        if(cStr.hasPrefix("#")){
            cStr = cStr.substring(from: 1) as NSString
        }
        
        if(cStr.length != 6){
            return UIColor.clear;
        }
        
        let rStr = (cStr as NSString).substring(to: 2)
        let gStr = ((cStr as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bStr = ((cStr as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r : UInt32 = 0x0
        var g : UInt32 = 0x0
        var b : UInt32 = 0x0
        
        Scanner.init(string: rStr).scanHexInt32(&r);
        Scanner.init(string: gStr).scanHexInt32(&g);
        Scanner.init(string: bStr).scanHexInt32(&b);
        
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(alpha));
        
    }
    
}
