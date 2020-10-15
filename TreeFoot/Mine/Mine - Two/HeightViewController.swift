//
//  HeightViewController.swift
//  TreeFoot
//
//  Created by 樊鸣远 on 2020/9/28.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class HeightViewController: UIViewController {

    var string:String = "170"
    
    
    func callBack(closure:@escaping ClosureName)  {
                  self.closure = closure
              }
       typealias ClosureName = (String)->()
       var closure : ClosureName!

       lazy var nameLabel:UILabel={
           let label = UILabel()
           let attrString = NSMutableAttributedString(string: "   请正确选择你的身高哦")
           label.numberOfLines = 0
           let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 16)!,.foregroundColor: UIColor(red: 0.6, green: 0.56, blue: 0.56,alpha:1), ]
           attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
           label.attributedText = attrString
           label.alpha = 1
           return label
       }()
       
    
    lazy var emojiPickerView: UIPickerView = {
          let pickerView = UIPickerView(frame: CGRect(x: 10, y: CFHeight / 2 - 150, width: CFWidth - 20, height: 200))
          pickerView.dataSource = self
          pickerView.delegate = self
          pickerView.selectRow(170, inComponent: 0, animated: true)
          return pickerView
      }()
    
       
       @objc func clickbutton(){
           guard (self.closure != nil) else {
                return
            }
           closure(string)
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
           view.addSubview(nameLabel)
           nameLabel.snp.makeConstraints{ (make) in
                      make.width.equalTo(200.fit)
                      make.height.equalTo(22.fit)
                      make.top.equalToSuperview().offset(105.fit)
                      make.left.equalToSuperview().offset(0.fit)
                  }
        view.addSubview(emojiPickerView)
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

extension HeightViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 300
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textAlignment = .center
        pickerLabel.font = UIFont.systemFont(ofSize: 60)
        pickerLabel.text = String(number4[row])
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        string = String(pickerView.selectedRow(inComponent: 0))
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
}


