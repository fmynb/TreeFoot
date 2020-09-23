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
    
    var datas = [Fav]()
    
    
    public func updateUI(with data:[Fav]) {
        self.datas = data
        self.FavcollectionView.reloadData()
    }
    
    lazy var backView: UIView = {
        let vi = UIView()
        vi.layer.cornerRadius = 15.fit
        return vi
    }()
    lazy var daily:UILabel = {
       let label = UILabel()
        let attrString = NSMutableAttributedString(string: "最近偏爱")
        label.frame = CGRect(x: 15.fit, y: 264.fit, width: 86.fit, height: 28.fit)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 20),.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1;
       return label
    }()
    
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
            make.right.equalTo(self).offset(-20.fit)
            make.top.equalTo(self).offset(60.fit)
            make.height.equalTo(180.fit)
            }
        self.addSubview(daily)

        
        self.daily.snp.makeConstraints{ (make) in
            make.height.equalTo(28.fit)
            make.width.equalTo(200.fit)
            make.left.equalToSuperview().offset(15.fit)
            make.top.equalToSuperview().offset(10.fit)
        }
    }
}

extension FavCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavId, for: indexPath) as! FavCell
        cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.Favcontentview.image = UIImage(named: self.datas[indexPath.row].img)
        //cell.Favcontentview.image = UIImage(named: "FavCollectionViewCell-1")
        return cell
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
         make.left.equalToSuperview().offset(0.fit)
         make.top.equalToSuperview().offset(0.fit)
         make.height.equalTo(164.fit)
        make.width.equalTo(153.fit)
        }
    }
}
