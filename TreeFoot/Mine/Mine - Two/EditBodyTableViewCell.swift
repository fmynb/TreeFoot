//
//  EditBodyTableViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class EditBodyTableViewCell: UITableViewCell {

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
        
    }

}
