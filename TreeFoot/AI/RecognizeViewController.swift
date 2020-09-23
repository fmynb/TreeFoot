//
//  RecognizeViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/22.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

// AI识别类
class RecognizeViewController: UIViewController, UIScrollViewDelegate {

    
    // 左边按钮
    private lazy var leftBarButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mine_icon_set")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.black
        button.tintColor = UIColor.black
        button.setImage(imageView.image, for: .normal)
        button.addTarget(self, action: #selector(calendarClick), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    @objc func calendarClick() {
        let calendarVC = CalendarViewController()
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
    
    lazy var bgImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "素食拼盘")
        return imageview
    }()
    
    lazy var image: UIImageView = {
        let imageview = UIImageView()
                imageview.image = UIImage(named: "素食拼盘")
        return imageview
    }()
    
    lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.delegate = self
            scrollView.showsVerticalScrollIndicator = false
            return scrollView
    }()
        
    lazy var contentView:UIView = {
        let vi = UIView()
        return vi
    }()
    
    // result
    lazy var resultView: UIView = {
       let vi = UIView()
        vi.backgroundColor = .white
        vi.layer.cornerRadius = 20.fit
        vi.layer.masksToBounds = true
        return vi
    }()
    
    // 结果
    var maybeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 24.fit)
        label.textColor = UIColor.init(r: 56, g: 56, b: 56 )
        label.text = "你要找的可能是"
        return label
    }()
    var maybeImage: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    
    lazy var resultViewTop: ResultView = {
       let result = ResultView()
        return result
    }()
    
    // 推荐
    lazy var recommendView: UIView = {
       let vi = UIView()
        vi.backgroundColor = .white
        vi.layer.cornerRadius = 20.fit
        vi.layer.masksToBounds = true
        return vi
    }()
    
    // 结果
    var recommendLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 24.fit)
        label.textColor = UIColor.init(r: 56, g: 56, b: 56 )
        label.text = "为你推荐"
        return label
    }()
    
    var recommendViewLeft: RecommendView = {
       let recommendView = RecommendView()
        return recommendView
    }()
    
    var recommendViewRight: RecommendView = {
       let recommendView = RecommendView()
        return recommendView
    }()
    
    var recognizeImage = UIImage()
    
    
    convenience init(image:UIImage) {
        self.init()
        self.recognizeImage = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.view.backgroundColor = UIColor.init(r: 248, g: 248, b: 248, alpha: 0.2)

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(CFHeight+(180.fit-kNavBarAndStatusBarHeight))
        }
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            
            make.height.equalTo(CFHeight+(180.fit-kNavBarAndStatusBarHeight))
        }

        contentView.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10.fit)
            make.left.equalToSuperview().offset(20.fit)
            make.right.equalToSuperview().offset(-20.fit)
            make.height.equalTo(CFHeight/3)
        }
        
        configResultUI()
        configRecommendUI()
        
    }
    
    func configResultUI() {
        contentView.addSubview(resultView)
        resultView.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom).offset(-10.fit)
            make.left.equalToSuperview().offset(10.fit)
            make.right.equalToSuperview().offset(-10.fit)
            make.height.equalTo(300.fit)
        }
        
    }
    func configRecommendUI() {
        contentView.addSubview(recommendView)
        recommendView.snp.makeConstraints { (make) in
            make.top.equalTo(resultView.snp.bottom).offset(10.fit)
            make.left.equalToSuperview().offset(10.fit)
            make.right.equalToSuperview().offset(-10.fit)
            make.height.equalTo(300.fit)
        }
        recommendView.addSubview(recommendViewLeft)
        recommendViewLeft.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10.fit)
            make.left.equalToSuperview().offset(10.fit)
            make.width.equalTo((CFWidth-20.fit)/2)
            make.height.equalTo(300.fit)
        }
        recommendView.addSubview(recommendViewRight)
        recommendViewRight.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10.fit)
            make.right.equalToSuperview().offset(-10.fit)
            make.width.equalTo((CFWidth-20.fit)/2)
            make.height.equalTo(300.fit)
        }
    }
    
    func configNavbar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
    }
    
    

}

extension RecognizeViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
    }
}
