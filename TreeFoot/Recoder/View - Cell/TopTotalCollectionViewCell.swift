//
//  TopTotalCollectionViewCell.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit

class TopTotalCollectionViewCell: UICollectionViewCell {
    // MARK: - 私有属性
    
    // 卡片背景视图
    private lazy var backView: UIView = {
        let view = UIView()
        // shadowCode
        view.layer.shadowColor = UIColor(red: 0.35, green: 0.15, blue: 0, alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        // fill
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 24
        view.alpha = 1
        return view
    }()
    
    // 体重渐变视图
    private lazy var weightGradientView: UIView = {
        let layerView = UIView()
        layerView.frame = CGRect(x: 30.fit, y: 15.fit, width: 44.fit, height: 6.fit)
        // fill
        let bgGradient = CAGradientLayer()
        bgGradient.colors = [UIColor(red: 0.96, green: 0.46, blue: 0.33, alpha: 1).cgColor, UIColor(red: 0.98, green: 0.93, blue: 0.88, alpha: 1).cgColor]
        bgGradient.locations = [0, 1]
        bgGradient.frame = layerView.bounds
        bgGradient.startPoint = CGPoint(x: 0.5, y: 0)
        bgGradient.endPoint = CGPoint(x: 0.5, y: 1)
        layerView.layer.addSublayer(bgGradient)
        layerView.layer.cornerRadius = 3
        layerView.layer.masksToBounds = true
        layerView.alpha = 1
        return layerView
    }()
    
    // 体重标题标签
    private lazy var weightLabel = getTitleLabel(placeHolder: "体重")
    
    // 体重数值标签
    private lazy var weightNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    // 体重单位标签
    private lazy var weightUnitLabel: UILabel = {
        let label = UILabel()
        let attributedStr = NSMutableAttributedString(string: "kg")
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 13)!,.foregroundColor: UIColor(red: 0.45, green: 0.45, blue: 0.45,alpha:1), ]
        attributedStr.addAttributes(attr, range: NSRange(location: 0, length: attributedStr.length))
        label.attributedText = attributedStr
        return label
    }()
    
    // 体重显示视图
    private lazy var weightView: UIView = {
        let view = UIView()
        view.addSubview(self.weightNumberLabel)
        view.addSubview(self.weightUnitLabel)
        self.weightNumberLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(2.fit)
            make.bottom.equalToSuperview().offset(-2.fit)
            make.left.equalToSuperview()
        }
        
        self.weightUnitLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(6.fit)
            make.bottom.equalToSuperview().offset(-6.fit)
            make.left.equalTo(self.weightNumberLabel.snp.right).offset(6.fit)
            make.right.equalToSuperview().offset(-4.fit)
        }
        return view
    }()
    
    // 卡路里渐变视图
    private lazy var caloriesGradientView: UIView = {
        let layerView = UIView()
        layerView.frame = CGRect(x: 30.fit, y: 95.fit, width: 44.fit, height: 6.fit)
        let bgGradient = CAGradientLayer()
        bgGradient.colors = [UIColor(red: 0.26, green: 0.85, blue: 0.8, alpha: 1).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
        bgGradient.locations = [0, 1]
        bgGradient.frame = layerView.bounds
        bgGradient.startPoint = CGPoint(x: 0.5, y: 0)
        bgGradient.endPoint = CGPoint(x: 0.5, y: 1)
        layerView.layer.addSublayer(bgGradient)
        layerView.layer.cornerRadius = 3
        layerView.layer.masksToBounds = true
        layerView.alpha = 1
        return layerView
    }()
    
    // 卡路里标题视图
    private lazy var caloriesLabel = getTitleLabel(placeHolder: "摄入")
    
    // 卡路里数值视图
    private lazy var caloriesNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    // 卡路里单位视图
    private lazy var caloriesUnitLabel: UILabel = {
        let label = UILabel()
        let attributedStr = NSMutableAttributedString(string: "cal")
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 13)!,.foregroundColor: UIColor(red: 0.45, green: 0.45, blue: 0.45,alpha:1), ]
        attributedStr.addAttributes(attr, range: NSRange(location: 0, length: attributedStr.length))
        label.attributedText = attributedStr
        return label
    }()
    
    // 卡路里显示视图
    private lazy var caloriesView: UIView = {
        let view = UIView()
        view.addSubview(self.caloriesNumberLabel)
        view.addSubview(self.caloriesUnitLabel)
        self.caloriesNumberLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(2.fit)
            make.bottom.equalToSuperview().offset(-2.fit)
            make.left.equalToSuperview()
        }
        
        self.caloriesUnitLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(6.fit)
            make.bottom.equalToSuperview().offset(-6.fit)
            make.left.equalTo(self.caloriesNumberLabel.snp.right).offset(6.fit)
            make.right.equalToSuperview().offset(-4.fit)
        }
        return view
    }()
    
    // 圆环视图
    private lazy var roundView: ZCCircleProgree = {
        let progressView = ZCCircleProgree()
        progressView.updateUI(with: 30)
        return progressView
    }()
    
    // MARK: - 公有方法
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 更新Cell数据
    /// - Parameters:
    ///   - weight: 体重
    ///   - calories: 卡路里
    ///   - percent: 剩余消耗 0-100
    public func updateUI(weight: Int, calories: Int, percent: Int) {
        // 体重数值
        let weightAttrString = NSMutableAttributedString(string: String(weight))
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 19)!,.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        weightAttrString.addAttributes(attr, range: NSRange(location: 0, length: weightAttrString.length))
        self.weightNumberLabel.attributedText = weightAttrString
        
        
        // 卡路里数值
        let caloriesAttrString = NSMutableAttributedString(string: String(calories))
        let attr2: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 19)!,.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        caloriesAttrString.addAttributes(attr2, range: NSRange(location: 0, length: caloriesAttrString.length))
        self.caloriesNumberLabel.attributedText = caloriesAttrString
        
        // 圆环
        roundView.updateUI(with: percent)
    }
    
    // MARK: - 私有方法
    
    private func setUpUI(){
        backView.addSubview(weightGradientView)
        backView.addSubview(weightLabel)
        backView.addSubview(weightView)
        backView.addSubview(caloriesGradientView)
        backView.addSubview(caloriesLabel)
        backView.addSubview(caloriesView)
        backView.addSubview(roundView)
        addSubview(backView)
        
        // layout
        
        weightLabel.snp.makeConstraints { (make) in
            make.width.equalTo(50.fit)
            make.height.equalTo(22.fit)
            make.left.equalToSuperview().offset(30.fit)
            make.top.equalTo(self.weightGradientView.snp.bottom).offset(6.fit)
        }
        
        weightView.snp.makeConstraints { (make) in
            make.width.equalTo(60.fit)
            make.height.equalTo(30.fit)
            make.left.equalToSuperview().offset(30.fit)
            make.top.equalTo(self.weightLabel.snp.bottom).offset(4.fit)
        }
        
        caloriesLabel.snp.makeConstraints { (make) in
            make.width.equalTo(50.fit)
            make.height.equalTo(22.fit)
            make.left.equalToSuperview().offset(30.fit)
            make.top.equalTo(self.caloriesGradientView.snp.bottom).offset(6.fit)
        }
        
        caloriesView.snp.makeConstraints { (make) in
            make.width.equalTo(60.fit)
            make.height.equalTo(30.fit)
            make.left.equalToSuperview().offset(30.fit)
            make.top.equalTo(self.caloriesLabel.snp.bottom).offset(4.fit)
        }
        
        backView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20.fit)
            make.right.equalTo(self.snp.right).offset(-20.fit)
            make.top.equalToSuperview().offset(10.fit)
            make.bottom.equalToSuperview().offset(-10.fit)
        }
        
        roundView.snp.makeConstraints { (make) in
            make.width.height.equalTo(140.fit)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-30.fit)
        }
    }
}

// MAKR: - 辅助方法


/// 获取标题标签
/// - Parameter placeHolder: 占位符
/// - Returns: Label
fileprivate func getTitleLabel(placeHolder: String) -> UILabel {
    let label = UILabel()
    let attrString = NSMutableAttributedString(string: placeHolder)
    label.numberOfLines = 0
    let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 15)!,.foregroundColor: UIColor(red: 0.45, green: 0.45, blue: 0.45,alpha:1), ]
    attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
    label.attributedText = attrString
    label.alpha = 1
    return label
}



let endPointMargin: CGFloat = 3.fit

let PI: CGFloat = 3.14159265358979323846264338327950288
let PI_2:CGFloat = 1.57079632679489661923132169163975144

// MARK: - 圆环类

class ZCCircle: UIView {

    public var progress:CGFloat = 0.0
    public var lineWidth:CGFloat = 10.fit
    
    
    private var trackLayer = CAShapeLayer()
    private var progressLayer =  CAShapeLayer()
    private var endPoint = UIView()
    let backLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configUI()
    }
    
    func configUI(){
        let centerX = self.bounds.size.width/2.0;
        let centerY = self.bounds.size.height/2.0;
        //半径
        let radius = (self.bounds.size.width-lineWidth)/2.0;
        //创建贝塞尔路径
        
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: -0.5 * PI, endAngle: 1.5 * PI, clockwise: true)
        backLayer.frame = bounds
        backLayer.fillColor = UIColor.clear.cgColor
        backLayer.strokeColor = UIColor.init(r: 50, g: 50, b: 50,alpha: 0.2).cgColor
        backLayer.lineWidth = lineWidth
        backLayer.path = path.cgPath
        backLayer.strokeEnd = 1
        layer.addSublayer(backLayer)
        
        progressLayer = CAShapeLayer()
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        //指定path的渲染颜色
        progressLayer.strokeColor = UIColor.init(r: 255, g: 255, b: 255,alpha: 1).cgColor //UIColor.black.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeEnd = 0
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor(red: 0.99, green: 0.45, blue: 0.38, alpha: 1).cgColor, UIColor(red: 0.99, green: 0.45, blue: 0.38, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.mask = progressLayer //用progressLayer来截取渐变层
        layer.addSublayer(gradientLayer)
        
    }
    
    func updateUI(value:CGFloat) {
        let rangeValue = abs(value)
        self.progressLayer.strokeEnd = rangeValue / 100.0
        self.progress = rangeValue / 100.0
        self.progressLayer.removeAllAnimations()
        backLayer.strokeColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1).cgColor
        progressLayer.strokeColor = UIColor.init(r: 255, g: 255, b: 255,alpha: 1).cgColor
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ZCCircleProgree:UIView {
    
    
    lazy var circle: ZCCircle = {
        let circle = ZCCircle(frame: CGRect(x: 0, y: 0, width: 140.fit, height: 140.fit))
        let lineWidth: Float = Float(0.1 * bounds.size.width)
        circle.lineWidth = CGFloat(lineWidth)
        return circle
    }()
    
    lazy var percentLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){

        addSubview(circle)
        addSubview(percentLabel)
        
        circle.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        percentLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    func updateUI(with value: Int) {
        circle.progress = CGFloat(value)
        let str = String(value)
        let strlen = str.count
        let attr1: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 13)!,.foregroundColor: UIColor(red: 0.76, green: 0.76, blue: 0.76,alpha:1), ]
        let attr2: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Light", size: 25)!,.foregroundColor: UIColor(red: 0.96, green: 0.46, blue: 0.33,alpha:1), ]
        let attrString = NSMutableAttributedString(string: "剩余\n" + str + "\n千卡")
        attrString.addAttributes(attr1, range: NSRange(location: 0, length: 3))
        attrString.addAttributes(attr2, range: NSRange(location: 3, length: strlen))
        attrString.addAttributes(attr1, range: NSRange(location: strlen + 3, length: attrString.length - strlen - 3))
        self.percentLabel.attributedText = attrString
        self.percentLabel.numberOfLines = 0
        circle.updateUI(value: CGFloat(value))
    }
}
