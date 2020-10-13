//
//  FavViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/23.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class FavViewController: UIViewController {

    var cellCallBack: ((FavMore) -> Void)?
      var datas = [FavMore]()
      
      public func updateUI(with data:[FavMore]) {
          datas = data
          self.collectionView.reloadData()
      }
      
      lazy var collectionView:UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical
          let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
          collectionView.backgroundColor = .clear
          collectionView.dataSource = self as UICollectionViewDataSource
          collectionView.delegate = self as UICollectionViewDelegate
          collectionView.showsVerticalScrollIndicator = false
          collectionView.register(FavViewControllerviewcell.classForCoder(), forCellWithReuseIdentifier: "reusedcell")
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
              make.height.equalTo(CFHeight - 150.fit)
              make.width.equalTo(CFWidth - 60.fit)
              make.top.equalToSuperview().offset(110.fit)
              make.left.equalToSuperview().offset(30.fit)
          }
      }
      
      func configNavbar() {
          self.navigation.bar.isShadowHidden = true
          self.navigation.bar.alpha = 0
          self.navigation.item.title = "最近偏爱"
      }
}

extension FavViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reusedcell", for: indexPath) as! FavViewControllerviewcell
        cell.updataUI(with: datas[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailvc = RecipeDetailViewController()
        navigationController?.pushViewController(detailvc, animated: true)
    }

}

extension FavViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 345.fit, height: 175.fit)
       }
       
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 60.fit
       }
    
}

class FavViewControllerviewcell:UICollectionViewCell{
    
    func updataUI(with data: FavMore){
        contentImage.image = UIImage(named: data.img)
        nameLabel.text = data.name
    }
    
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        let attrString = NSMutableAttributedString(string: "素食拼盘")
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Regular", size: 15)!,.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    
    lazy var contentImage: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    
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
