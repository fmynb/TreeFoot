//
//  SearchCollectionViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import SnapKit
import UIKit
import Macaw

fileprivate let searchId = "reusedCell"

// TODO: 顶部搜索+左右列表滑动
class SearchCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
    // MARK: - 公有属性
    
    public var photoCallBack: (() -> ())?
    public var searchBarCallBack: (() -> ())?
    public var eatCallBack: ((IntakeOfType) -> ())?
    
    // MARK: - 私有属性
    
    private var datas = [Eat]()
    
    // 背景图
    private lazy var backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15.fit
        return view
    }()
    
    // 搜索大背景
    private lazy var searchView: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.init(r: 240, g: 240, b: 240)
        vi.layer.cornerRadius = 20.fit
        vi.layer.masksToBounds = true
        return vi
    }()
    
    private lazy var searchBarBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.textAlignment = .left
        //btn.setImage(UIImage(named: "diary_icon_search"), for: .normal)
        //btn.isUserInteractionEnabled = false
        btn.addTarget(self, action: #selector(searchBarClick), for: .touchUpInside)
        return btn
    }()
    
    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.fit)
        label.textColor = UIColor.init(r: 56, g: 56, b: 56 )
        label.text = "搜索"
        
        return label
    }()
    
    private lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "diary_icon_search"), for: .normal)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    private lazy var photoBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "home_takephoto"), for: .normal)
        btn.addTarget(self, action: #selector(photo), for: .touchUpInside)
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false//隐藏滑动条
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.register(SearchCell.classForCoder(), forCellWithReuseIdentifier: searchId)
        return collectionView
    }()
    
    
    
    
    // MARK: - 公有方法
    
    public func updateUI(with data: [Eat]) {
        self.datas = data
        self.collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        //configShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - 私有方法
    @objc func searchBarClick() {
        if let callback = searchBarCallBack {
            callback()
        }
    }
    
    @objc func photo() {
        print("photocallback")
        if let callback = photoCallBack {
            callback()
        }
    }
    
    private func configUI() {
        backgroundColor = .white
        addSubview(collectionView)
        addSubview(searchView)
        searchView.addSubview(searchBtn)
        searchView.addSubview(titleLabel)
        searchView.addSubview(searchBarBtn)
        searchView.addSubview(photoBtn)
        
        
        collectionView.snp.makeConstraints{ make in
            make.left.equalTo(self).offset(12.fit)
            make.right.equalToSuperview()
            make.top.equalTo(self.searchView.snp.bottom).offset(18.fit)
            make.height.equalTo(110.fit)
        }
        
        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20.fit)
            make.right.equalTo(self).offset(-20.fit)
            make.top.equalTo(self).offset(10.fit)
            make.height.equalTo(40.fit)
        }
        
        searchBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30.fit)
            make.width.equalTo(30.fit)
            make.centerY.equalTo(self.searchView.snp.centerY)
            make.height.equalTo(30.fit)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(70.fit)
            make.width.equalTo(40.fit)
            make.centerY.equalTo(self.searchView.snp.centerY)
            make.height.equalTo(30.fit)
        }
        
        searchBarBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(70.fit)
            make.right.equalTo(self).offset(-90.fit)
            make.centerY.equalTo(self.searchView.snp.centerY)
            make.height.equalTo(30.fit)
        }
        
        photoBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-30.fit)
            make.centerY.equalTo(self.searchView.snp.centerY)
            make.width.height.equalTo(30.fit)
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

// MARK: - UICollectionViewDataSource协议

extension SearchCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchId, for: indexPath) as! SearchCell
        cell.updateUI(with: datas[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(indexPath.row)
        if let callback = eatCallBack {
            switch indexPath.row {
            case 0:
                callback(.BreakFast)
            case 1:
                callback(.Launch)
            case 2:
                callback(.Dinner)
            case 3:
                callback(.Snacks)
            default:
                break;
            }
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout协议

extension SearchCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.fit, height: 100.fit)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.fit
    }
}


class SearchCell: UICollectionViewCell {
    
    public func updateUI(with data: Eat) {
        self.imageView.image = UIImage(named: data.img)
        self.infoLabel.text = data.name
    }
    
    private lazy var backView: UIView = {
        let layerView = UIView()
        // shadowCode
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.17).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 6
        // fill
        layerView.backgroundColor = UIColor(red: 0.99, green: 0.98, blue: 0.97, alpha: 1)
        layerView.layer.cornerRadius = 14;
        layerView.alpha = 1
        return layerView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageVIew = UIImageView()
        imageVIew.backgroundColor = .clear
        imageVIew.image = UIImage(named: "header")
        imageVIew.contentMode = .scaleAspectFill
        return imageVIew
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "早餐")
        label.frame = CGRect(x: 45, y: 184, width: 27, height: 18)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 13)!,.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.textAlignment = .center
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .clear
        
        addSubview(backView)
        backView.addSubview(infoLabel)
        backView.addSubview(imageView)
        
        
        backView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(4.fit)
            make.bottom.right.equalToSuperview().offset(-4.fit)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10.fit)
            make.width.height.equalTo(44.fit)
        }
        
        infoLabel.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(40.fit)
            make.height.equalTo(30.fit)
            make.top.equalTo(self.imageView.snp.bottom).offset(2.fit)
        }
    }
    
}

