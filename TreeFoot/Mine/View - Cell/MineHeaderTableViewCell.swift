//
//  MineHeaderTableViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class MineHeaderTableViewCell: UITableViewCell {

    
    public func updateUI(with data: MineHeaderModel) {
        self.userImg.image = UIImage(named: data.img)
        self.userName.text = data.username
        self.bodyWrightLabel.text = data.bodyweight
        self.heightLabel.text = data.height
    }
    
    lazy var userImg: UIImageView = {
       let vi = UIImageView()
        //vi.backgroundColor=UIColor.red
        vi.layer.cornerRadius = 40.fit
        vi.layer.masksToBounds = true
        vi.image = UIImage(named: "mine_img_header")
        vi.contentMode = .scaleAspectFill
        return vi
    }()
    
    lazy var userName: UILabel = {
       let label = UILabel()
        label.text = "去冰无糖"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 18.fit)
        return label
    }()
    lazy var sexIcon: UIImageView = {
       let img = UIImageView()
        return img
    }()
    
   
    lazy var bodyWrightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.fit)
        label.text = "52"
        label.textColor = UIColor.orange
        return label
    }()
    
    
    lazy var bodyUnitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.fit)
        label.text = "kg"
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var lineView: UIView = {
       let vi = UIView()
        vi.backgroundColor = .lightGray
        return vi
    }()
   
    lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.fit)
        label.text = "168"
        label.textColor = UIColor.orange
        return label
    }()
    
    
    lazy var heightUnitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.fit)
        label.text = "cm"
        label.textColor = UIColor.black
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
        addSubview(userImg)
        userImg.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30.fit)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(80.fit)
            make.width.equalTo(80.fit)
        }
        addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(140.fit)
            make.bottom.equalTo(self.snp.centerY).offset(-5.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(100.fit)
        }
        addSubview(sexIcon)
        sexIcon.snp.makeConstraints { (make) in
            make.left.equalTo(userName.snp.right).offset(10.fit)
            make.bottom.equalTo(self.snp.centerY).offset(-10.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(20.fit)
        }
        addSubview(bodyWrightLabel)
        bodyWrightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(140.fit)
            make.top.equalTo(self.snp.centerY).offset(10.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(25.fit)
        }
        addSubview(bodyUnitLabel)
        bodyUnitLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bodyWrightLabel.snp.right).offset(0.fit)
            make.bottom.equalTo(bodyWrightLabel.snp.bottom).offset(-5.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(15.fit)
        }
        
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(210.fit)
            make.top.equalTo(self.snp.centerY).offset(15.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(2.fit)
        }
        
        addSubview(heightLabel)
        heightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp.right).offset(30.fit)
            make.top.equalTo(self.snp.centerY).offset(10.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(30.fit)
        }
        addSubview(heightUnitLabel)
        heightUnitLabel.snp.makeConstraints { (make) in
            make.left.equalTo(heightLabel.snp.right).offset(0.fit)
            make.bottom.equalTo(heightLabel.snp.bottom).offset(-5.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(20.fit)
        }
    }

}
