//
//  searchCell.swift
//  TreeFoot
//
//  Created by 王韬 on 2020/9/20.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class searchCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 20, y: 50, width: 60, height: 60))
        image.layer.cornerRadius = 14
        image.backgroundColor = UIColor(red: 0.99, green: 0.98, blue: 0.97, alpha: 1)
        image.alpha = 1
        image.layer.masksToBounds = true
        return image
    }()

    lazy var infoLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: 350, height: 40))
        label.layer.cornerRadius = 10
        label.backgroundColor = .clear
        return label
    }()

    lazy var effectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = CGRect(x: 20, y: 360, width: 350, height: 40)
        effectView.layer.masksToBounds = true
        effectView.layer.cornerRadius = 5
        return effectView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 1
        layer.shadowRadius = 6
        backgroundColor = UIColor(red: 0.98, green: 0.97, blue: 0.97, alpha: 1)
        layer.cornerRadius = 14
        alpha = 1
        contentView.addSubview(imageView)
        contentView.addSubview(effectView)
//        self.contentView.addSubview(infoLabel)
    }
}
