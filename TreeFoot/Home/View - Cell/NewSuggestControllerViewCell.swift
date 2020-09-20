//
//  NewSuggestControllerViewCell.swift
//  TreeFoot
//
//  Created by mac bookPro on 2020/9/18.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

struct Pattern  {
    let image: String
    let name: String
}

class NewSuggestControllerViewCell: UICollectionViewCell {
    
    lazy var contentview: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    lazy var namelabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(red: 116/225.0, green: 116/225.0, blue: 116/225.0, alpha: 1.0)
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 20.fit)
        return label
    }()
    
    lazy var cheaklabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(red: 84/255.0, green: 88/255.0, blue: 90/255.0, alpha: 1.0)
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 20.fit)
        return label
    }()
    
    lazy var starone: UIImageView = {
        let starone = UIImageView()
        return starone
        }()
    
    lazy var startwo: UIImageView = {
        let starone = UIImageView()
        return starone
    }()
    
    lazy var starthree: UIImageView = {
        let starone = UIImageView()
        return starone
    }()
    lazy var starfour: UIImageView = {
            let starone = UIImageView()
        return starone
    }()
    
    lazy var starfive: UIImageView = {
        let starone = UIImageView()
        return starone
    }()
    
    override func layoutSubviews() {
//        super.layoutSubviews()
        self.addSubview(contentview)
        self.addSubview(namelabel)
        self.addSubview(cheaklabel)
        self.addSubview(starone)
        self.addSubview(startwo)
        self.addSubview(starthree)
        self.addSubview(starfour)
        self.addSubview(starfive)
        self.contentview.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(0.fit)
            make.top.equalToSuperview().offset(-2.fit)
            make.height.equalTo(120.fit)
            make.width.equalTo(120.fit)
        }
        self.namelabel.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(130.fit)
            make.top.equalToSuperview().offset(30.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(150.fit)
        }

        self.cheaklabel.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-10.fit)
            make.top.equalToSuperview().offset(30.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(60.fit)
        }

        self.starone.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(130.fit)
            make.top.equalToSuperview().offset(75.fit)
            make.height.equalTo(15.fit)
            make.width.equalTo(15.fit)
        }
        
        self.startwo.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(155.fit)
            make.top.equalToSuperview().offset(75.fit)
            make.height.equalTo(15.fit)
            make.width.equalTo(15.fit)
        }
        
        self.starthree.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(180.fit)
            make.top.equalToSuperview().offset(75.fit)
            make.height.equalTo(15.fit)
            make.width.equalTo(15.fit)
        }
        
        self.starfour.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(205.fit)
            make.top.equalToSuperview().offset(75.fit)
            make.height.equalTo(15.fit)
            make.width.equalTo(15.fit)
        }
        
        self.starfive.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(230.fit)
            make.top.equalToSuperview().offset(75.fit)
            make.height.equalTo(15.fit)
            make.width.equalTo(15.fit)
        }
    }

}
