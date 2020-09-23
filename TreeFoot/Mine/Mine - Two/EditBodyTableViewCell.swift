//
//  EditBodyTableViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class EditBodyTableViewCell: UITableViewCell {
     
    
    lazy var lefttext:UILabel = {
      let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    
    lazy var centertext:UILabel = {
      let label = UILabel()
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
        self.addSubview(lefttext)
        lefttext.snp.makeConstraints{ (make) in
            make.width.equalTo(84.fit)
            make.height.equalTo(22.fit)
            make.left.equalToSuperview().offset(22.fit)
            make.top.equalToSuperview().offset(15.fit)
        }
        self.addSubview(centertext)
        centertext.snp.makeConstraints{ (make) in
            make.width.equalTo(104.fit)
            make.height.equalTo(22.fit)
            make.left.equalToSuperview().offset(103.fit)
            make.top.equalToSuperview().offset(15.fit)
    }

}
    
}
