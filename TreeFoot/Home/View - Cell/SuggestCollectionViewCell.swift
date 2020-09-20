//
//  SuggestCollectionViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

// TODO 建议补充Cell
let id = "reusedcell"
let Frame = UIScreen.main.bounds
let Width = Frame.width
let Height = Frame.height
class SuggestCollectionViewCell: HomeBaseCollectionViewCell {
    
    
    private var data = [
        Pattern(image: "SuggestCollection-1", name: "乳清蛋白粉"),
        Pattern(image: "SuggestCollection-2", name: "维生素C"),
    ]
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collect = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collect.backgroundColor = .clear
        collect.dataSource = self as UICollectionViewDataSource
        collect.delegate = self as UICollectionViewDelegate
        collect.register(NewSuggestControllerViewCell.classForCoder(), forCellWithReuseIdentifier: id)
        return collect
    }()
    
    lazy var backView:UIView = {
           let vi = UIView()
            vi.layer.cornerRadius = 15.fit//优化图片圆角
            return vi
        }()
    
    private func configUI(){
            self.backgroundColor = .white
            addSubview(backView)
            addSubview(collection)
            collection.snp.makeConstraints{ (make) in
                make.left.equalTo(self).offset(10.fit)
                make.right.equalTo(self).offset(-10.fit)
                make.top.equalTo(self).offset(50.fit)
                make.height.equalTo(300.fit)
            }
            backView.snp.makeConstraints{(make) in
                make.left.equalTo(self).offset(20.fit)
                make.right.equalTo(self).offset(-20.fit)
                make.top.equalTo(self).offset(50.fit)
                make.height.equalTo(300.fit)
            }//设置collectionview的高宽
    }
    
//    private func configShadow(){
//            self.backView.backgroundColor = UIColor(red: 246/255.0, green: 247/255.0, blue: 252/225.0, alpha: 1.0)
//            self.backView.layer.cornerRadius = 15.fit
//            self.backView.layer.masksToBounds = false
//            self.backView.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.22).cgColor
//            self.backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
//            self.backView.layer.shadowOpacity = 1
//            self.backView.layer.shadowRadius = 4.fit
//        }
}

  
extension SuggestCollectionViewCell: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! NewSuggestControllerViewCell
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor//颜色
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)//阴影偏移量
        cell.layer.shadowOpacity = 1//阴影透明度
        cell.layer.shadowRadius = 6//
        cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.contentview.image = UIImage(named: data[indexPath.row].image)
        cell.namelabel.text = data[indexPath.row].name
        cell.cheaklabel.text = "查看"
        cell.starone.image = UIImage(named: "mine_icon_set")
        cell.startwo.image = UIImage(named: "mine_icon_set")
        cell.starthree.image = UIImage(named: "mine_icon_set")
        cell.starfour.image = UIImage(named: "mine_icon_set")
        cell.starfive.image = UIImage(named: "mine_icon_set")

        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
}

extension SuggestCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Width-40, height: 100)
    }//设置collectionviewcell的高宽
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }//设置cell的间隔
    
}


//    lazy var backView:UIView = {
//       let vi = UIView()
//
//        vi.layer.cornerRadius = 15.fit
//        return vi
//    }()
//
//    lazy var backViewtwo:UIView = {
//       let vitwo = UIView()
//
//        vitwo.layer.cornerRadius = 15.fit
//        return vitwo
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configUI()
//        configUItwo()
//        configShadow()
////        configShadowtwo()
//
//
//    }
//
//        required init?(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//
//
//    lazy var ImgOne: UIImageView = {
//       let vi = UIImageView()
//        vi.layer.cornerRadius = 10.fit//优化图片圆角
//        vi.layer.masksToBounds = true
//        vi.image = UIImage(named: "SuggestCollection-1")
//        vi.contentMode = .scaleAspectFill
//        return vi
//    }()
//
//    lazy var ImgTwo: UIImageView = {
//       let vi = UIImageView()
//        vi.layer.cornerRadius = 10.fit//优化图片圆角
//        vi.layer.masksToBounds = true
//        vi.image = UIImage(named: "SuggestCollection-2")
//        vi.contentMode = .scaleAspectFill
//        return vi
//    }()
//
//
//    lazy var ImgToOne: UIImageView = {
//       let vi = UIImageView()
//        vi.layer.cornerRadius = 10.fit//优化图片圆角
//        vi.layer.masksToBounds = true
//        vi.image = UIImage(named: "mine_icon_set")
//        vi.contentMode = .scaleAspectFill
//        return vi
//    }()
//
//    lazy var ImgToTwo: UIImageView = {
//       let vi = UIImageView()
//        vi.layer.cornerRadius = 10.fit//优化图片圆角
//        vi.layer.masksToBounds = true
//        vi.image = UIImage(named: "mine_icon_set")
//        vi.contentMode = .scaleAspectFill
//        return vi
//    }()
//
//    lazy var ImgToThree: UIImageView = {
//       let vi = UIImageView()
//        vi.layer.cornerRadius = 10.fit//优化图片圆角
//        vi.layer.masksToBounds = true
//        vi.image = UIImage(named: "mine_icon_set")
//        vi.contentMode = .scaleAspectFill
//        return vi
//    }()
//
//    lazy var ImgToFour: UIImageView = {
//       let vi = UIImageView()
//        vi.layer.cornerRadius = 10.fit
//        vi.layer.masksToBounds = true
//        vi.image = UIImage(named: "mine_icon_set")
//        vi.contentMode = .scaleAspectFill
//        return vi
//    }()
//
//    lazy var ImgToFive: UIImageView = {
//       let vi = UIImageView()
//        vi.layer.cornerRadius = 10.fit//优化图片圆角
//        vi.layer.masksToBounds = true
//        vi.image = UIImage(named: "mine_icon_set")
//        vi.contentMode = .scaleAspectFill
//        return vi
//    }()
//
//
//    lazy var NameOneToOne: UILabel = {
//       let label = UILabel()
//        label.text = "乳清蛋白粉"
//        label.textColor = UIColor(red: 116/225.0, green: 116/225.0, blue: 116/225.0, alpha: 1.0)
//        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 20.fit)
//        return label
//    }()
//
//    lazy var NameTwoToOne: UILabel = {
//       let label = UILabel()
//        label.text = "维生素C"
//        label.textColor = UIColor(red: 116/225.0, green: 116/225.0, blue: 116/225.0, alpha: 1.0)
//        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 20.fit)
//        return label
//    }()
//
//
//    lazy var NameOneToTwo: UILabel = {
//        let label = UILabel()
//        label.text = "查看"
//        label.textColor = UIColor(red: 84/255.0, green: 88/255.0, blue: 90/255.0, alpha: 1.0)
//        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 20.fit)
//        return label
//    }()
//
//    lazy var NameTwoToTwo: UILabel = {
//        let label = UILabel()
//        label.text = "查看"
//        label.textColor = UIColor(red: 84/255.0, green: 88/255.0, blue: 90/255.0, alpha: 1.0)
//        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 20.fit)
//        return label
//    }()
//
//
//
//
//        private func configUI(){
//            self.backgroundColor = .white
//            addSubview(backView)
//            backView.snp.makeConstraints{(make) in
//                make.left.equalTo(self).offset(20.fit)
//                make.right.equalTo(self).offset(-20.fit)
//                make.top.equalTo(self).offset(60.fit)
//                make.height.equalTo(110.fit)
//            }
//
//            addSubview(ImgTwo)
//            ImgTwo.snp.makeConstraints { (make) in
//                make.left.equalTo(self).offset(15.fit)
//                make.top.equalTo(self).offset(60.fit)
//                make.height.equalTo(120.fit)
//                make.width.equalTo(120.fit)
//            }
//            addSubview(NameOneToOne)
//            NameOneToOne.snp.makeConstraints { (make) in
//                make.left.equalTo(self).offset(160.fit)
//                make.top.equalTo(self).offset(90.fit)
//                make.height.equalTo(20.fit)
//                make.width.equalTo(150.fit)
//            }
//
//            addSubview(ImgToOne)
//            ImgToOne.snp.makeConstraints { (make) in
//                make.left.equalTo(self).offset(160.fit)
//                make.top.equalTo(self).offset(130.fit)
//                make.height.equalTo(15.fit)
//                make.width.equalTo(15.fit)
//            }
//
//            addSubview(ImgToTwo)
//            ImgToTwo.snp.makeConstraints { (make) in
//                make.left.equalTo(self).offset(185.fit)
//                make.top.equalTo(self).offset(130.fit)
//                make.height.equalTo(15.fit)
//                make.width.equalTo(15.fit)
//            }
//
//            addSubview(ImgToThree)
//            ImgToThree.snp.makeConstraints { (make) in
//                make.left.equalTo(self).offset(210.fit)
//                make.top.equalTo(self).offset(130.fit)
//                make.height.equalTo(15.fit)
//                make.width.equalTo(15.fit)
//            }
//
//            addSubview(ImgToFour)
//            ImgToFour.snp.makeConstraints { (make) in
//                make.left.equalTo(self).offset(235.fit)
//                make.top.equalTo(self).offset(130.fit)
//                make.height.equalTo(15.fit)
//                make.width.equalTo(15.fit)
//            }
//
//            addSubview(ImgToFive)
//            ImgToFive.snp.makeConstraints { (make) in
//                make.left.equalTo(self).offset(260.fit)
//                make.top.equalTo(self).offset(130.fit)
//                make.height.equalTo(15.fit)
//                make.width.equalTo(15.fit)
//            }
//
//            addSubview(NameOneToTwo)
//            NameOneToTwo.snp.makeConstraints { (make) in
//                make.right.equalTo(self).offset(-20.fit)
//                make.top.equalTo(self).offset(90.fit)
//                make.height.equalTo(20.fit)
//                make.width.equalTo(60.fit)
//
//            }
//
//        }
//
//        private func configShadow(){
//            self.backView.backgroundColor = UIColor(red: 246/255.0, green: 247/255.0, blue: 252/225.0, alpha: 1.0)
//            self.backView.layer.cornerRadius = 15.fit
//            self.backView.layer.masksToBounds = false
//            self.backView.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.22).cgColor
//            self.backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
//            self.backView.layer.shadowOpacity = 1
//            self.backView.layer.shadowRadius = 4.fit
//        }
//
//
//    private func configUItwo(){
//        self.backgroundColor = .white
//        addSubview(backViewtwo)
//
//
//        backViewtwo.snp.makeConstraints{(make) in
//            make.left.equalTo(self).offset(20.fit)
//            make.right.equalTo(self).offset(-20.fit)
//            make.top.equalTo(self).offset(180.fit)
//            make.height.equalTo(110.fit)
//
//         }
//
//
//        addSubview(ImgOne)
//        ImgOne.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(15.fit)
//            make.top.equalTo(self).offset(180.fit)
//            make.height.equalTo(120.fit)
//            make.width.equalTo(120.fit)
//        }
//        addSubview(NameTwoToOne)
//        NameTwoToOne.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(160.fit)
//            make.top.equalTo(self).offset(210.fit)
//            make.height.equalTo(20.fit)
//            make.width.equalTo(150.fit)
//        }
//
//        addSubview(ImgToOne)
//        ImgToOne.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(160.fit)
//            make.top.equalTo(self).offset(220.fit)
//            make.height.equalTo(15.fit)
//            make.width.equalTo(15.fit)
//        }
//
//        addSubview(ImgToTwo)
//        ImgToTwo.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(185.fit)
//            make.top.equalTo(self).offset(220.fit)
//            make.height.equalTo(15.fit)
//            make.width.equalTo(15.fit)
//        }
//
//        addSubview(ImgToThree)
//        ImgToThree.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(210.fit)
//            make.top.equalTo(self).offset(220.fit)
//            make.height.equalTo(15.fit)
//            make.width.equalTo(15.fit)
//        }
//
//        addSubview(ImgToFour)
//        ImgToFour.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(235.fit)
//            make.top.equalTo(self).offset(220.fit)
//            make.height.equalTo(15.fit)
//            make.width.equalTo(15.fit)
//        }
//
//        addSubview(ImgToFive)
//        ImgToFive.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(260.fit)
//            make.top.equalTo(self).offset(220.fit)
//            make.height.equalTo(15.fit)
//            make.width.equalTo(15.fit)
//        }
//
//        addSubview(NameTwoToTwo)
//        NameTwoToTwo.snp.makeConstraints { (make) in
//            make.right.equalTo(self).offset(-20.fit)
//            make.top.equalTo(self).offset(210.fit)
//            make.height.equalTo(20.fit)
//            make.width.equalTo(60.fit)
//
//        }
//
//    }
//
////    private func configShadowtwo(){
////        self.backViewtwo.backgroundColor = UIColor(red: 246/255.0, green: 247/255.0, blue: 252/225.0, alpha: 1.0)
////        self.backViewtwo.layer.cornerRadius = 15.fit
////        self.backViewtwo.layer.masksToBounds = false
////        self.backViewtwo.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.22).cgColor
////        self.backViewtwo.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
////        self.backViewtwo.layer.shadowOpacity = 1
////        self.backViewtwo.layer.shadowRadius = 4.fit
////    }
//

