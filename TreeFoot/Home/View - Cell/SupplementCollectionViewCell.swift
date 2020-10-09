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
        self.Pageview = PageView(frame: CGRect(x: 12.fit, y: CellTopOffset - 10.fit, width: Int(CFWidth) - 24.fit, height: 300.fit), style: self.style, titles: titles, childViewControllers: controllers)
        self.addSubview(Pageview)
    }
    
    lazy var daily:UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "营养补给")
        label.frame = CGRect(x: 15.fit, y: 264.fit, width: 86.fit, height: 28.fit)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 20)!,.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
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
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collect = UICollectionView(frame: CGRect(x: -10, y: 0, width: CFWidth, height: 300.fit), collectionViewLayout: layout)
        collect.backgroundColor = .clear
        collect.dataSource = self as UICollectionViewDataSource
        collect.delegate = self as UICollectionViewDelegate
        collect.register(NewSuggestControllerViewCell.classForCoder(), forCellWithReuseIdentifier: suggestId)
        return collect
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.self.addSubview(collection)
    }
}

extension containview: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: suggestId, for: indexPath) as! NewSuggestControllerViewCell
        cell.updateUI(with: datas.content[indexPath.row])//datas[indexPath.row])
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
        return CGSize(width: CFWidth, height: 100.fit)
    }//设置collectionviewcell的高宽
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.fit
    }//设置cell的间隔
    
}
