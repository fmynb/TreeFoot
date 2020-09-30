//
//  SexViewController.swift
//  TreeFoot
//
//  Created by 樊鸣远 on 2020/9/30.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class SexViewController: UIViewController {

    typealias ClosureName = (String)->()
          var closure : ClosureName!
       
       
          func callBack(closure:@escaping ClosureName){
           self.closure = closure
          }
       
          lazy var backButtonFemale:UIButton = {
            let button = UIButton()
            button.addTarget(self, action: #selector(clickbuttonwoman), for: .touchUpInside)
            let image = UIImage(named: "女")
            button.setImage(image, for: .normal)
            button.layer.borderColor = UIColor(red: 0.91, green: 0.89, blue: 0.89, alpha: 1).cgColor
            button.layer.borderWidth = 1
            button.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 0.37)
            button.layer.cornerRadius = 50
            button.alpha = 1
            return button
          }()
       
         lazy var backButtonMale:UIButton = {
            let button = UIButton()
            button.addTarget(self, action: #selector(clickbuttonman), for: .touchUpInside)
            let image = UIImage(named: "男")
            button.setImage(image, for: .normal)
            button.layer.borderColor = UIColor(red: 0.91, green: 0.89, blue: 0.89, alpha: 1).cgColor
            button.layer.borderWidth = 1
            button.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 0.37)
            button.layer.cornerRadius = 50
            button.alpha = 1
            return button
         }()
    
    lazy var womanLabel:UILabel = {
       let label = UILabel()
        label.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.cornerRadius = 20
        label.alpha = 1
        label.text = "女"
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var manLabel:UILabel = {
       let label = UILabel()
        label.text = "男"
        label.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.cornerRadius = 20
        label.alpha = 1
        label.backgroundColor = .clear
        return label
    }()
       
          
          @objc func clickbuttonwoman(){
              guard (self.closure != nil) else {
                   return
               }
              closure(womanLabel.text!)
              self.navigationController?.popViewController(animated: true)
          }
    
    
         @objc func clickbuttonman(){
                 guard (self.closure != nil) else {
                      return
                  }
                 closure(manLabel.text!)
                 self.navigationController?.popViewController(animated: true)
             }

          override func viewDidLoad() {
              super.viewDidLoad()
              configUI()
              self.view.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
              self.navigation.bar.isShadowHidden = true
              self.navigation.bar.alpha = 1
              self.navigation.item.title = "选择性别"
              self.hideKeyboardWhenTappedAround()
          }
          
          func configUI(){
              view.addSubview(backButtonFemale)
              backButtonFemale.snp.makeConstraints{ (make) in
                  make.width.equalTo(100)
                  make.height.equalTo(100)
                  make.top.equalToSuperview().offset(300)
                  make.left.equalToSuperview().offset(60)
              }
            view.addSubview(backButtonMale)
            backButtonMale.snp.makeConstraints{ (make) in
                make.width.equalTo(100)
                make.height.equalTo(100)
                make.top.equalToSuperview().offset(300)
                make.left.equalToSuperview().offset(260)
            }
            view.addSubview(womanLabel)
            womanLabel.snp.makeConstraints{ (make) in
                make.width.equalTo(18)
                make.width.equalTo(25)
                make.top.equalToSuperview().offset(420)
                make.left.equalToSuperview().offset(100)
            }
            view.addSubview(manLabel)
            manLabel.snp.makeConstraints{ (make) in
                make.width.equalTo(18)
                make.width.equalTo(25)
                make.top.equalToSuperview().offset(420)
                make.left.equalToSuperview().offset(300)
            }
          }
}

extension SexViewController{
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
