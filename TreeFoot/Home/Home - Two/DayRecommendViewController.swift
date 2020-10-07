//
//  DayRecommendViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/23.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class DayRecommendViewController: UIViewController {
    
    var data:[DayRecommendmore] = [DayRecommendmore(name:"早餐-鸡丝凉粉",img:"鸡丝凉粉")]
    
    lazy var collectionView:UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical
          let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
          collectionView.backgroundColor = .clear
          collectionView.dataSource = self as UICollectionViewDataSource
          collectionView.delegate = self as UICollectionViewDelegate
          collectionView.showsVerticalScrollIndicator = false
          collectionView.register(DayRecommendViewControllerCell.classForCoder(), forCellWithReuseIdentifier: "reusedcell")
          return collectionView
      }()
    
    override func viewDidLoad() {
         super.viewDidLoad()
         configUI()
         configNavbar()
         // Do any additional setup after loading the view.
     }
     
     func configUI() {
         self.view.backgroundColor = .white
         self.view.addSubview(collectionView)
         self.collectionView.snp.makeConstraints{ (make) in
            make.height.equalTo(CFHeight-78.fit)
            make.width.equalTo(CFWidth-60.fit)
                 make.top.equalToSuperview().offset(78.fit)
                 make.left.equalToSuperview().offset(30.fit)
             }
     }
     
     func configNavbar() {
         self.navigation.bar.isShadowHidden = true
         self.navigation.bar.alpha = 0
         self.navigation.item.title = "每日推荐"
     }

}

extension DayRecommendViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reusedcell", for: indexPath) as! DayRecommendViewControllerCell
        // shadowCode
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 6
        // fill
        cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.cornerRadius = 8
        cell.alpha = 1
        cell.updataUI(with: data[0])
        return cell
    }
    
    
}

extension DayRecommendViewController: UICollectionViewDelegateFlowLayout {


    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 345.fit, height: 175.fit)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60.fit
       }
    
}

class DayRecommendViewControllerCell:UICollectionViewCell {
    
    
    func updataUI(with data: DayRecommendmore){
        contentImage.image = UIImage(named: data.img)
        nameLabel.numberOfLines = 1
        let attrString = NSMutableAttributedString(string: data.name)
        nameLabel.numberOfLines = 2
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Regular", size: 13)!,.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
               attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        nameLabel.attributedText = attrString
        nameLabel.alpha = 1
    }
    
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()//菜品名字
    
//    lazy var materialsLabel: UILabel = {
//        let label = UILabel()
//        let attrString = NSMutableAttributedString(string: "素食拼盘")
//        label.numberOfLines = 2
//        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Regular", size: 13)!,.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
//        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
//        label.attributedText = attrString
//        label.alpha = 1
//        return label
//    }()//原料内容
    
    lazy var contentImage: UIImageView = {
        let imageview = UIImageView()
       // let image = UIImage(named: "素食拼盘")
       // imageview.image = image
        return imageview
    }()//菜品图片

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configUI(){
        self.addSubview(contentImage)
        self.addSubview(nameLabel)
        self.contentImage.snp.makeConstraints{ (make) in
            make.height.equalTo(175.fit)
            make.width.equalTo(345.fit)
            make.left.equalToSuperview().offset(0.fit)
            make.top.equalToSuperview().offset(0.fit)
        }
        self.nameLabel.snp.makeConstraints{ (make) in
            make.height.equalTo(18.fit)
            make.width.equalTo(260.fit)
            make.left.equalToSuperview().offset(0.fit)
            make.top.equalToSuperview().offset(190.fit)
        }

    }
  }
    
