//
//  WeightViewController.swift
//  TreeFoot
//
//  Created by 樊鸣远 on 2020/9/28.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit


let number1 = [0,1,2,3,4,5,6,7,8,9]
let number2 = [0,1,2,3,4,5,6,7,8,9]
let number3 = [0,1,2,3,4,5,6,7,8,9]
let number4 = [Int](0...300)

class WeightViewController: UIViewController {

    
    var string:String = ""
 
    func callBack(closure:@escaping ClosureName)  {
                  self.closure = closure
              }
       typealias ClosureName = (String)->()
       var closure : ClosureName!

       lazy var nameLabel:UILabel={
           let label = UILabel()
           let attrString = NSMutableAttributedString(string: "   请正确选择你的体重哦")
           label.numberOfLines = 0
           let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 16)!,.foregroundColor: UIColor(red: 0.6, green: 0.56, blue: 0.56,alpha:1), ]
           attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
           label.attributedText = attrString
           label.alpha = 1;
           return label
       }()
       
//       lazy var textField:UITextField={
//          let textfield = UITextField()
//           var information:String = "   "+bodydata[2].centerText
//           let attrString = NSMutableAttributedString(string: information)
//           let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 17),.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
//           attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
//           textfield.attributedText = attrString
//           textfield.backgroundColor = UIColor.white
//           textfield.alpha = 1
//           textfield.keyboardType = .default
//           return textfield
//       }()
    
    lazy var emojiPickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect(x: 10, y: CFHeight / 2 - 150, width: CFWidth - 20, height: 200))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(50, inComponent: 0, animated: true)
        return pickerView
    }()
           
       
       @objc func clickbutton(){
           guard (self.closure != nil) else {
                return
            }
           //closure(textField.text!)
           closure(string)
           self.navigationController?.popViewController(animated: true)
       }

       override func viewDidLoad() {
           super.viewDidLoad()
           configUI()
           self.view.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
           self.navigation.bar.isShadowHidden = true
           self.navigation.bar.alpha = 1
           self.navigation.item.title = "修改体重"
           self.navigation.item.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(clickbutton))
           self.hideKeyboardWhenTappedAround()
       }
       
       func configUI(){
//           view.addSubview(textField)
//           textField.snp.makeConstraints{ (make) in
//               make.width.equalTo(CFWidth)
//               make.height.equalTo(62.fit)
//               make.top.equalToSuperview().offset(146.fit)
//               make.left.equalToSuperview().offset(0)
//           }
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
extension WeightViewController{
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


extension WeightViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 301
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textAlignment = .center
        pickerLabel.font = UIFont.systemFont(ofSize: 60)
//        if component == 0 {
//            pickerLabel.text = String(number1[row])
//        } else if component == 1 {
//            pickerLabel.text = String(number2[row])
//        } else {
//            pickerLabel.text = String(number3[row])
//        }
        pickerLabel.text = String(number4[row])
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if(pickerView.selectedRow(inComponent: 0) == 0 && pickerView.selectedRow(inComponent: 1) != 0)
//        {
//             string = String(pickerView.selectedRow(inComponent: 1))+String(pickerView.selectedRow(inComponent: 2))
//        }
//        else if(pickerView.selectedRow(inComponent: 1) == 0 && pickerView.selectedRow(inComponent: 0) == 0)
//        {
//            string = String(pickerView.selectedRow(inComponent: 2))
//        }
//        else{
//            string = String(pickerView.selectedRow(inComponent: 0))+String(pickerView.selectedRow(inComponent: 1))+String(pickerView.selectedRow(inComponent: 2))
//        }
        string = String(pickerView.selectedRow(inComponent: 0))
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
}
