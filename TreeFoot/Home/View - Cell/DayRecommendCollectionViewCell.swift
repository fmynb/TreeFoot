//
//  DayRecommendCollectionViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit


// TODO 每日推荐Cell

let dayId = "reusedcell"
class DayRecommendCollectionViewCell: HomeBaseCollectionViewCell {
    
    // MARK: - 公有属性
    public var cellCallBack: ((Dish) -> ())?
    
    // MARK: - 私有属性
    private var data = DailyRecommendation()
    
    private lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collect = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collect.backgroundColor = .clear
        collect.dataSource = self as UICollectionViewDataSource
        collect.delegate = self as UICollectionViewDelegate
        collect.showsHorizontalScrollIndicator = false
        collect.register(DayRecommendCollectionViewChildCell.classForCoder(), forCellWithReuseIdentifier: dayId)
        return collect
    }()
    
    // MARK: - 公有方法
    
    public func updateUI(with data: DailyRecommendation) {
        self.data = data
        self.collectionview.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 私有方法
    
    private func configUI() {
        
        addSubview(collectionview)
        titleLabel.text = "每日推荐"
    
        collectionview.snp.makeConstraints{ (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(CellTopOffset)
            make.left.equalToSuperview().offset(12.fit)
            make.bottom.equalToSuperview()
        }
    }
        
}

extension DayRecommendCollectionViewCell: UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.dishes.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayId, for: indexPath) as! DayRecommendCollectionViewChildCell
        cell.updateUI(with: data.dishes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callback = self.cellCallBack {
            callback(data.dishes[indexPath.row])
        }
    }
    
    
}

extension DayRecommendCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165.fit, height: 250.fit)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.fit
    }
    
}


class DayRecommendCollectionViewChildCell: UICollectionViewCell {
    
    private lazy var backView: UIView = {
        let layerView = UIView()
        // shadowCode
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 6
        // fill
        layerView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        layerView.layer.cornerRadius = 6
        return layerView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "素食拼盘")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Semibold", size: 13)!,.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    lazy var materialslabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "用料：牛油果、鸡蛋、青菜")
        label.frame = CGRect(x: 28, y: 502, width: 122, height: 14)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 10)!,.foregroundColor: UIColor(red: 0.71, green: 0.68, blue: 0.68,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
    
    lazy var contentImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        return imageview
    }()
    
    public func updateUI(with data: Dish) {
        self.nameLabel.text = data.name
        self.materialslabel.text = data.description
        self.contentImageView.image = UIImage(named: data.image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(6.fit)
            make.right.bottom.equalToSuperview().offset(-6.fit)
        }
        backView.addSubview(contentImageView)
        backView.addSubview(nameLabel)
        backView.addSubview(materialslabel)
        contentImageView.snp.makeConstraints{ (make) in
            make.height.equalTo(160.fit)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        nameLabel.snp.makeConstraints{ (make) in
            make.height.equalTo(20.fit)
            make.width.equalTo(80.fit)
            make.left.equalToSuperview().offset(14.fit)
            make.top.equalTo(self.contentImageView.snp.bottom).offset(10.fit)
        }
        materialslabel.snp.makeConstraints{ (make) in
            make.bottom.equalToSuperview().offset(-4.fit)
            make.right.equalToSuperview().offset(-14.fit)
            make.left.equalToSuperview().offset(14.fit)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(4.fit)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
