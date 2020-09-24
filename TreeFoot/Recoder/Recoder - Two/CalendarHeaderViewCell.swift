//
//  CalendarHeaderViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/24.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class CalendarHeaderViewCell: UITableViewHeaderFooterView {
    
    // 标题
     var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 24.fit)
        label.textColor = UIColor.init(r: 56, g: 56, b: 56 )
        label.text = "6月15日"
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        setUI()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(20.fit)
            make.width.equalTo(300.fit)
            make.height.equalTo(30.fit)
        }
    }

}
