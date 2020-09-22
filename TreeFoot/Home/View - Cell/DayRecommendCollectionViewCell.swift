//
//  DayRecommendCollectionViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit


// TODO 每日推荐Cell

let id = "reusedcell"
class DayRecommendCollectionViewCell: HomeBaseCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var daily:UILabel = {
       let label = UILabel()
        let attrString = NSMutableAttributedString(string: "每日推荐")
        label.frame = CGRect(x: 15.fit, y: 264.fit, width: 86.fit, height: 28.fit)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 20),.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1;
       return label
    }()
    
    
    
    
    lazy var collectionview:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collect = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collect.backgroundColor = .clear
        collect.dataSource = self as UICollectionViewDataSource
        collect.delegate = self as UICollectionViewDelegate
        collect.showsHorizontalScrollIndicator = false
        collect.register(DayRecommendCollectionViewChildCell.classForCoder(), forCellWithReuseIdentifier: id)
        return collect
    }()   //定义collectionview
    
    
    
    func configUI() {
        
        self.addSubview(collectionview)
        self.addSubview(daily)
        
        self.collectionview.snp.makeConstraints{ (make) in
            make.height.equalTo(270.fit)
            make.width.equalTo(420.fit)
            make.top.equalToSuperview().offset(40.fit)
            make.left.equalToSuperview().offset(15.fit)
        }
        
        
        self.daily.snp.makeConstraints{ (make) in
            make.height.equalTo(28.fit)
            make.width.equalTo(86.fit)
            make.left.equalToSuperview().offset(15.fit)
            make.top.equalToSuperview().offset(10.fit)
            }
        }
}

extension DayRecommendCollectionViewCell: UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! DayRecommendCollectionViewChildCell
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        cell.layer.shadowOffset = CGSize(width: 0.fit, height: 5.fit)
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 6
        cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.cornerRadius = 8
        cell.contentimage.image = UIImage(named: "素食拼盘")
        cell.namelabel.text = "素食拼盘"
        cell.materialslabel.text = "用料：牛油果，鸡蛋，香菜，山楂"
        return cell
    }
    
    
}

extension DayRecommendCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 153.fit, height: 260.fit)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.fit
    }
    
}


//
//  DayRecommendCollectionViewChildCell.swift
//  TreeFoot
//
//  Created by 樊鸣远 on 2020/9/17.
//  Copyright © 2020 Hut. All rights reserved.
//


class DayRecommendCollectionViewChildCell: UICollectionViewCell {
    
    lazy var namelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()//菜品名字
    
    lazy var materialslabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "素食拼盘")
        label.numberOfLines = 2
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 13),.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()//原料内容
    
    lazy var contentimage: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()//菜品图片
    
    override func layoutSubviews() {
        self.addSubview(contentimage)
        self.addSubview(namelabel)
        self.addSubview(materialslabel)
        self.contentimage.snp.makeConstraints{ (make) in
            make.height.equalTo(164.fit)
            make.width.equalTo(153.fit)
            make.left.equalToSuperview().offset(0.fit)
            make.top.equalToSuperview().offset(0.fit)
        }
        self.namelabel.snp.makeConstraints{ (make) in
            make.height.equalTo(28.fit)
            make.width.equalTo(80.fit)
            make.left.equalToSuperview().offset(13.fit)
            make.top.equalToSuperview().offset(180.fit)
        }
        self.materialslabel.snp.makeConstraints{ (make) in
            make.height.equalTo(50.fit)
            make.width.equalTo(142.fit)
            make.left.equalToSuperview().offset(13.fit)
            make.top.equalToSuperview().offset(197.fit)
            
            
            
        }
    }
}
