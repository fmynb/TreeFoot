//
//  RecipeViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var cellCallBack: ((Dish) -> Void)?

    private var data = Dishes()
    
    public func updateUI(with data: Dishes) {
        self.data = data
        self.collectionview.reloadData()
    }
    
    lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        layout.scrollDirection = .vertical
        collectionview.showsVerticalScrollIndicator = false
        collectionview.register(RecipeViewControllerMealCell.classForCoder(), forCellWithReuseIdentifier: dayId)
        collectionview.delegate = self as UICollectionViewDelegate
        collectionview.dataSource = self as UICollectionViewDataSource
        return collectionview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
    }

    func configUI() {
        view.backgroundColor = .white
        view.addSubview(collectionview)
        collectionview.snp.makeConstraints { make in
            make.width.equalTo(CFWidth.fit)
            make.height.equalTo(834.fit)
            make.left.equalTo(0.fit)
            make.top.equalTo(11.fit)
        }
    }

    func configNavbar() {
        navigation.bar.isShadowHidden = true
//        navigation.bar.alpha = 0
    }
}



extension RecipeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.content.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayId, for: indexPath) as! RecipeViewControllerMealCell
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        cell.layer.shadowOffset = CGSize(width: 0.fit, height: 5.fit)
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 6
        cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.cornerRadius = 8
        cell.updateUI(with: data.content[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailvc = RecipeDetailViewController()
        detailvc.updateUI(data.content[indexPath.row])
        navigationController?.pushViewController(detailvc, animated: true)
        if let callback = cellCallBack {
            callback(data.content[indexPath.row])
        }
    }
}



extension RecipeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180.fit, height: 291.fit)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.fit
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 21, left: 13, bottom: 0, right: 13)
    }
}




class RecipeViewControllerMealCell: UICollectionViewCell {
    
    public func updateUI(with data: Dish) {
        namelabel.text = data.name
        materialslabel.text = data.description
        contentimage.image = UIImage(named: data.image)
    }

    lazy var contentimage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "素食拼盘")
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        return imageview
    }() // 菜品图片
    
    lazy var namelabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "素食拼盘")
        label.numberOfLines = 2
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 15)!, .foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }() // 菜品名字

    lazy var materialslabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "用料：牛油果、鸡蛋、青菜、山楂")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 12)!, .foregroundColor: UIColor(red: 0.71, green: 0.68, blue: 0.68, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }() // 原料内容

    override func layoutSubviews() {
        addSubview(contentimage)
        addSubview(namelabel)
        addSubview(materialslabel)
        contentimage.snp.makeConstraints { make in
            make.height.equalTo(201.fit)
            make.width.equalTo(180.fit)
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        namelabel.snp.makeConstraints { make in
            make.height.equalTo(20.fit)
            make.width.equalTo(160.fit)
            make.left.equalToSuperview().offset(13.fit)
            make.top.equalTo(self.contentimage.snp.bottom).offset(14.fit)
        }
        
        materialslabel.snp.makeConstraints { make in
            make.height.equalTo(40.fit)
            make.width.equalTo(160.fit)
            make.left.equalToSuperview().offset(13.fit)
            make.top.equalTo(self.namelabel.snp.bottom).offset(0.fit)
        }
    }
}
