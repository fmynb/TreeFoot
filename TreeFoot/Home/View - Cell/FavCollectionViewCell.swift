//
//  FavCollectionViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
fileprivate let FavId = "reusedCell"

// TODO 最近偏爱Cell
class FavCollectionViewCell: HomeBaseCollectionViewCell {
    
    var datas = [Dish]()
    var cellCallBack: ((Dish, Int) -> ())?
    
    public func updateUI(with data:[Dish]) {
        self.datas = data
        self.FavcollectionView.reloadData()
    }
    
    lazy var FavcollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let FavcollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal//横向滚动
        FavcollectionView.backgroundColor = .clear
        FavcollectionView.dataSource = self
        FavcollectionView.showsHorizontalScrollIndicator = false//隐藏滑动条
        FavcollectionView.alwaysBounceHorizontal = true
        FavcollectionView.delegate = self
        FavcollectionView.register(FavCell.classForCoder(), forCellWithReuseIdentifier: FavId)
        return FavcollectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        backgroundColor = .white
        addSubview(FavcollectionView)
        FavcollectionView.snp.makeConstraints{ make in
            make.left.equalTo(self).offset(15.fit)
            make.right.equalTo(self)
            make.top.equalTo(self).offset(CellTopOffset - 8.fit)
            make.height.equalTo(180.fit)
        }
        titleLabel.text = "最近偏爱"
    }
}

extension FavCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavId, for: indexPath) as! FavCell
        cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.Favcontentview.image = UIImage(named: self.datas[indexPath.row].image)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callback = self.cellCallBack {
            print("建议cell回调")
            callback(datas[indexPath.row], indexPath.row)
        }
    }
    
}

extension FavCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 153, height: 164)
    }//设置item的大小
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }//设置item的间距
}



class FavCell: UICollectionViewCell {
    
    lazy var Favcontentview: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    
    override func layoutSubviews(){
        self.addSubview(Favcontentview)
        self.Favcontentview.snp.makeConstraints{ (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(160.fit)
            make.width.equalTo(160.fit)
        }
    }
}
