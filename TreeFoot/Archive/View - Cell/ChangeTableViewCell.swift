//
//  ChangeTableViewCell.swift
//  TreeFoot
//
//  Created by Ryan on 2020/9/24.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class ChangeTableViewCell: UITableViewCell {
    
    public lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BMI")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var backView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 6
        // fill
        layerView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        layerView.layer.cornerRadius = 20
        return layerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        selectionStyle = .none
        addSubview(backView)
        backView.backgroundColor = .white
        backView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24.fit)
            make.top.equalToSuperview().offset(20.fit)
            make.right.equalToSuperview().offset(-24.fit)
            make.bottom.equalToSuperview()
        }
        
        backView.addSubview(backImageView)
        
        backImageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(4.fit)
            make.bottom.right.equalToSuperview().offset(-4.fit)
        }
    }
}
