//
//  HeightViewController.swift
//  TreeFoot
//
//  Created by 樊鸣远 on 2020/9/28.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class HeightViewController: UIViewController {

    func callBack(closure:@escaping ClosureName)  {
                  self.closure = closure
              }
       typealias ClosureName = (String)->()
       var closure : ClosureName!

       lazy var nameLabel:UILabel={
           let label = UILabel()
           let attrString = NSMutableAttributedString(string: "请正确填写你的身高哦")
           label.numberOfLines = 0
           let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 16),.foregroundColor: UIColor(red: 0.6, green: 0.56, blue: 0.56,alpha:1), ]
           attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
           label.attributedText = attrString
           label.alpha = 1;
           return label
       }()
       
       lazy var textField:UITextField={
          let textfield = UITextField()
           var information:String = bodydata[1].centerText
           let attrString = NSMutableAttributedString(string: information)
           let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 17),.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
           attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
           textfield.attributedText = attrString
           textfield.backgroundColor = UIColor.white
           textfield.alpha = 1;
           textfield.keyboardType = .default
           return textfield
       }()
    
       
       @objc func clickbutton(){
           guard (self.closure != nil) else {
                return
            }
           closure(textField.text!)
           self.navigationController?.popViewController(animated: true)
       }

       override func viewDidLoad() {
           super.viewDidLoad()
           configUI()
           self.view.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
           self.navigation.bar.isShadowHidden = true
           self.navigation.bar.alpha = 1
           self.navigation.item.title = "修改身高"
           self.navigation.item.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(clickbutton))
           self.hideKeyboardWhenTappedAround()
       }
       
       func configUI(){
           view.addSubview(textField)
           textField.snp.makeConstraints{ (make) in
               make.width.equalTo(CFWidth)
               make.height.equalTo(62.fit)
               make.top.equalToSuperview().offset(146.fit)
               make.left.equalToSuperview().offset(0)
           }
           view.addSubview(nameLabel)
           nameLabel.snp.makeConstraints{ (make) in
                      make.width.equalTo(200.fit)
                      make.height.equalTo(22.fit)
                      make.top.equalToSuperview().offset(96.fit)
                      make.left.equalToSuperview().offset(0.fit)
                  }
       }
}
extension HeightViewController{
    //隐藏键盘
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

