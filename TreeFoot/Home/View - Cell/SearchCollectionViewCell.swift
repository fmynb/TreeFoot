//
//  SearchCollectionViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import SnapKit
import UIKit
fileprivate let id = "reusedCell"

// TODO: 顶部搜索+左右列表滑动
class SearchCollectionViewCell: UICollectionViewCell {
    lazy var backView: UIView = {
        let vi = UIView()
        vi.layer.cornerRadius = 15.fit
        return vi
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false//隐藏滑动条
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.register(searchCell.classForCoder(), forCellWithReuseIdentifier: id)
        return collectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        //configShadow()
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configUI() {
        backgroundColor = .white
        addSubview(collectionView)
        collectionView.snp.makeConstraints{ make in
            make.left.equalTo(self).offset(15.fit)
            make.right.equalTo(self).offset(-20.fit)
            make.centerY.equalTo(self)
            make.height.equalTo(122.fit)
        }
    }

    private func configShadow() {
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 15.fit
        backView.layer.masksToBounds = false
        backView.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        backView.layer.shadowOpacity = 1
        backView.layer.shadowRadius = 12.fit
    }
}
extension SearchCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! searchCell
        return cell
    }
    
    
}

extension SearchCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 89, height: 89)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
}

//extension ViewController: UIScrollViewDelegate {
//    //Tells the delegate when the user finishes scrolling the content.
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let originPoint = targetContentOffset.pointee
//        var index = Int(originPoint.x / ScreenWidth)
//        let offset = Int(originPoint.x) % Int(ScreenWidth)
//        index += (offset > Int(ScreenWidth/2)) ? 1 : 0
//        targetContentOffset.pointee = CGPoint(x: index * Int(ScreenWidth), y: 0)
//    }
//}
