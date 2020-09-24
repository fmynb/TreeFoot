//
//  SupplementCollectionViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
import DNSPageView

// TODO: 营养补给Cell
class SupplementCollectionViewCell: HomeBaseCollectionViewCell {
    
    var cellCallBack: ((Suggest) -> ())?
    
    public func updateUI(with data:[Paln]) {
        var titles = [String]()
        var controllers = [UIViewController]()
        for paln in data {
            titles.append(paln.name)
            let vc = containview(data: paln)
            if let callback = self.cellCallBack {
                vc.cellCallBack = callback
            }
            controllers.append(vc)
        }
        self.Pageview = PageView(frame: CGRect(x: 10.fit, y: 45.fit, width: CFWidth-20.fit, height: 300.fit), style: self.style, titles: titles, childViewControllers: controllers)
        self.addSubview(Pageview)
    }
    
    lazy var daily:UILabel = {
       let label = UILabel()
        let attrString = NSMutableAttributedString(string: "营养补给")
        label.frame = CGRect(x: 15.fit, y: 264.fit, width: 86.fit, height: 28.fit)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 20),.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1;
       return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    lazy var style: PageStyle = {
                let style = PageStyle()
        //        style.titleViewHeight =
                style.isShowCoverView = true
                style.coverViewBackgroundColor = UIColor(red: 0.97, green: 0.58, blue: 0.48, alpha: 1)
                style.coverViewAlpha = 1
                style.coverViewRadius = 13
                style.coverViewHeight = 25
                style.coverMargin = 8
                style.titleSelectedColor = UIColor(red: 1, green: 1, blue: 1,alpha:1)
                style.isTitleViewScrollEnabled = true
                style.isTitleScaleEnabled = true
        return style
    }()
    var Pageview: PageView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.titleLabel.text = "营养补给"
    }
}
class containview: UIViewController {
    
    var cellCallBack: ((Suggest) -> ())?
    
    var datas = Paln()
    convenience init(data: Paln) {
        self.init()
        self.datas = data
    }
    
    private var data = [
        Pattern(image: "SuggestCollection-1", name: "乳清蛋白粉"),
        Pattern(image: "SuggestCollection-2", name: "维生素C"),
    ]
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collect = UICollectionView(frame: CGRect(x: 0, y: 0, width: CFWidth-20.fit, height: 300.fit), collectionViewLayout: layout)
        collect.backgroundColor = .clear
        collect.dataSource = self as UICollectionViewDataSource
        collect.delegate = self as UICollectionViewDelegate
        collect.register(NewSuggestControllerViewCell.classForCoder(), forCellWithReuseIdentifier: suggestId)
        return collect
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.self.addSubview(collection)
//        collection.snp.makeConstraints{ (make) in
//            make.left.equalTo()
//            make.right.equalTo()
//            make.top.equalTo()
//            make.height.equalTo(300.fit)
//        }
    }
}
extension containview: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: suggestId, for: indexPath) as! NewSuggestControllerViewCell
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor//颜色
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)//阴影偏移量
        cell.layer.shadowOpacity = 1//阴影透明度
        cell.layer.shadowRadius = 6//
        cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.updateUI(with: datas.content[indexPath.row])//datas[indexPath.row])
//        cell.contentview.image = UIImage(named: data[indexPath.row].image)
//        cell.namelabel.text = data[indexPath.row].name
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callback = self.cellCallBack {
            print("营养补给cell回调")
            callback(datas.content[indexPath.row])
        }
    }
}
extension containview: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Width-40, height: 110)
    }//设置collectionviewcell的高宽
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }//设置cell的间隔
    
}
