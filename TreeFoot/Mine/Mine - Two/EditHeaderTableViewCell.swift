//
//  EditHeaderTableViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class EditHeaderTableViewCell: UITableViewCell {
    

    lazy var headerimageview: UIImageView = {
       let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = 32
        imageview.clipsToBounds = true
        return imageview
    }()
    
    
    lazy var modifyheaderimage:UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "修改头像")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 16)!,.foregroundColor: UIColor(red: 0.57, green: 0.54, blue: 0.54,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.addSubview(headerimageview)
        headerimageview.snp.makeConstraints{ (make) in
            make.width.equalTo(64.fit)
            make.height.equalTo(64.fit)
            make.left.equalToSuperview().offset(22.fit)
            make.top.equalToSuperview().offset(19.fit)
    }
        self.addSubview(modifyheaderimage)
        modifyheaderimage.snp.makeConstraints{ (make) in
            make.width.equalTo(64.fit)
            make.height.equalTo(22.fit)
            make.left.equalToSuperview().offset(103.fit)
            make.top.equalToSuperview().offset(40.fit)
        }
        
}
}
