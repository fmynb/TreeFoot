//
//  EditUserInfoViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
let editid="reusedcell"
let bodycell="EditBodyTableViewCell"
let headercell="EditHeaderTableViewCell"
let filePath: String = NSHomeDirectory() + "/Documents/test.plist"
var plistdata = NSMutableArray(contentsOfFile: filePath)

//var bodydata:[EditModel] = [EditModel(leftText: "修改名字", centerText: "去冰无糖"),EditModel(leftText: "身高", centerText: "168"),EditModel(leftText: "体重", centerText: "52"),EditModel(leftText: "性别", centerText: "女"),EditModel(leftText: "生日", centerText: "2001-07-15")]

var bodydata = [EditModel]()


class EditUserInfoViewController: UIViewController{
    
     
    var imagepick:UIImagePickerController!
    var headerimage = UIImage(named: "去冰无糖头像")
    
    private lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.isScrollEnabled = false
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
        tableview.register(EditBodyTableViewCell.classForCoder(), forCellReuseIdentifier: bodycell)
        tableview.register(EditHeaderTableViewCell.classForCoder(), forCellReuseIdentifier: headercell)
        return tableview
    }()
    
    lazy var editordatalabel:UILabel = {
        let label = UILabel()
        label.text = "编辑资料"
        label.numberOfLines = 0
        label.font = UIFont(name: "PingFang SC", size: 16)
        label.textColor = UIColor(red: 0.57, green: 0.54, blue: 0.54,alpha:1)
        label.alpha = 1
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
    }
    
    func configUI() {
        self.view.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
        view.addSubview(tableview)
        tableview.frame = CGRect(x: 0, y: 140, width: CFWidth, height: CFHeight)
        self.navigation.bar.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
        self.view.addSubview(editordatalabel)
        editordatalabel.snp.makeConstraints{(make) in
            make.width.equalTo(128.fit)
            make.height.equalTo(22.fit)
            make.left.equalToSuperview().offset(22.fit)
            make.top.equalToSuperview().offset(100.fit)
        }
    }
    
    func configNavbar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 1
        self.navigation.item.title = "编辑资料"
    }

}


extension EditUserInfoViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: headercell) as! EditHeaderTableViewCell
            cell.accessoryType = .disclosureIndicator
            cell.headerimageview.image = headerimage
            return cell
        }
        else
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: bodycell) as! EditBodyTableViewCell
            let index = indexPath.row
            
      //修改字体
            cell.lefttext.numberOfLines = 0
            cell.lefttext.font = UIFont(name: "PingFang SC", size: 16)
            cell.lefttext.textColor = UIColor(red: 0.57, green: 0.54, blue: 0.54,alpha:1)
            cell.lefttext.alpha = 1;
            
            cell.centertext.numberOfLines = 0
            cell.centertext.font = UIFont(name: "PingFang SC", size: 16)
            cell.centertext.textColor = UIColor(red: 0.57, green: 0.54, blue: 0.54,alpha:1)
            cell.centertext.alpha = 1
            for item in plistdata!{
                let data = item as! NSDictionary
                let center = data.value(forKey: "centerText") as! String
                let sss = EditModel(centerText: center)
                if(bodydata.count == 5)
                {
                    break
                }
                else
                {
                    bodydata.append(sss)
                }
                
            }
            switch index {
            case 1:
                cell.lefttext.text = "修改名字"
                cell.centertext.text = bodydata[index-1].centerText
            case 2:
                cell.lefttext.text = "身高"
                cell.centertext.text = bodydata[index-1].centerText + "cm"
            case 3:
                cell.lefttext.text = "体重"
                cell.centertext.text = bodydata[index-1].centerText + "kg"
            case 4:
                cell.lefttext.text = "性别"
                cell.centertext.text = bodydata[index-1].centerText
            case 5:
                cell.lefttext.text = "生日"
                cell.centertext.text = bodydata[index-1].centerText
            default :
                break
            }
            cell.accessoryType = .disclosureIndicator
            return cell
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0)
        {
            return 100
        }
        else
        {
        return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableview.deselectRow(at: indexPath, animated: true)
        let index = indexPath.row
                switch index {
                case 0:
                    alert1()
                case 1:
                    let nameView = NameViewController()
                    nameView.callBack { (value) in
                    bodydata[0].centerText = value
                    let array:NSMutableArray = NSMutableArray()
                    for item in bodydata{
                                            let dictionary:NSMutableDictionary = [ : ]
                                            let center = item.centerText as NSString
                                            dictionary.setValue(center, forKey: "centerText")
                                            array.add(dictionary)
                                        }
                             plistdata?.removeAllObjects()
                             array.write(toFile: filePath, atomically: false)
                             print(filePath)
                             tableView.reloadData()
                    }
                    self.navigationController?.pushViewController(nameView, animated: true)
                    
                case 2:
                    let heightView = HeightViewController()
                    heightView.callBack { (value) in
                    bodydata[1].centerText = value
                        let array:NSMutableArray = NSMutableArray()
                        for item in bodydata{
                            let dictionary:NSMutableDictionary = [ : ]
                            let center = item.centerText as NSString
                            dictionary.setValue(center, forKey: "centerText")
                            array.add(dictionary)
                        }
                        plistdata?.removeAllObjects()
                        array.write(toFile: filePath, atomically: false)
                       
                        tableView.reloadData()
                    }
                   self.navigationController?.pushViewController(heightView, animated: true)
                    
                case 3:
                    let weightView = WeightViewController()
                    weightView.callBack { (value) in
                    bodydata[2].centerText = value
                        let array:NSMutableArray = NSMutableArray()
                        for item in bodydata{
                                                let dictionary:NSMutableDictionary = [ : ]
                                                let center = item.centerText as NSString
                                                dictionary.setValue(center, forKey: "centerText")
                                                array.add(dictionary)
                                            }
                                 plistdata?.removeAllObjects()
                                 array.write(toFile: filePath, atomically: false)
                                
                                 tableView.reloadData()
                    }
                  self.navigationController?.pushViewController(weightView, animated: true)

                case 4:
                    let sexView = SexViewController()
                    sexView.callBack { (value) in
                      bodydata[3].centerText = value
                        let array:NSMutableArray = NSMutableArray()
                        for item in bodydata{
                                let dictionary:NSMutableDictionary = [ : ]
                                let center = item.centerText as NSString
                                dictionary.setValue(center, forKey: "centerText")
                                array.add(dictionary)
                                }
                                 plistdata?.removeAllObjects()
                                 array.write(toFile: filePath, atomically: false)
                                 
                      tableView.reloadData()
                      }
                    self.navigationController?.pushViewController(sexView, animated: true)

                    
                 case 5:
                    let birthdayView = birthdayViewController()
                    birthdayView.callBack { (value) in
                    bodydata[4].centerText = value
                    let array:NSMutableArray = NSMutableArray()
                    for item in bodydata{
                    let dictionary:NSMutableDictionary = [ : ]
                    let center = item.centerText as NSString
                    dictionary.setValue(center, forKey: "centerText")
                    array.add(dictionary)
                    }
                    plistdata?.removeAllObjects()
                    array.write(toFile: filePath, atomically: false)
                    
                    tableView.reloadData()
                    }
                    self.navigationController?.pushViewController(birthdayView, animated: true)
                default:
                    break
                }
     
    }
     func alert1()
    {
        let alert=UIAlertController(title: "更换头像", message: nil, preferredStyle: .alert)

        let yes = UIAlertAction(title: "拍照选取", style: .default, handler: {(alert:
            UIAlertAction)->Void in
            self.pickCamera()
            print("调用相机")
        })

        let no = UIAlertAction(title: "从相册选取", style: .default, handler: {(alert:
            UIAlertAction)->Void in
            print("调用相册")
            self.pickAlbum()

        })
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)

        alert.addAction(yes)
        alert.addAction(no)
        alert.addAction(cancel)
        self.present(alert,animated: true,completion: nil)
    }
}

extension EditUserInfoViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate{

     func pickAlbum(){
        self.imagepick=UIImagePickerController()
        self.imagepick.delegate=self
        self.imagepick.allowsEditing=true
        self.imagepick.sourceType = .photoLibrary
        self.present(self.imagepick,animated: true,completion: nil)
    }

    func pickCamera(){
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            self.imagepick = UIImagePickerController()
            self.imagepick.sourceType = .camera
            self.imagepick.showsCameraControls = true
            self.imagepick.delegate = self
            self.imagepick.allowsEditing = true
            self.imagepick.cameraDevice = .front
            self.present(self.imagepick,animated: true,completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.headerimage = info[.originalImage] as? UIImage
        tableview.reloadData()
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

