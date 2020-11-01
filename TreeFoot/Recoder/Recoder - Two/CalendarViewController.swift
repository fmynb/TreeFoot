//
//  CalendarViewController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/16.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController,UIGestureRecognizerDelegate {
    
    
    private var data:[TimeAndFood] = []
    
    public func updateUI(with data: [TimeAndFood]) {
           self.data = data
           self.tableView.reloadData()
       }

    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: CFWidth, height: 300.fit))
       calendar.dataSource = self
       calendar.delegate = self
        calendar.locale = NSLocale(localeIdentifier: "zh-CN") as Locale
        calendar.appearance.weekdayTextColor = UIColor(r: 120, g: 120, b: 120)
        calendar.appearance.headerTitleColor = UIColor(r: 112, g: 112, b: 112)
        
        calendar.placeholderType = .fillHeadTail
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        calendar.appearance.todayColor = .clear//UIColor(hex: "#F6C98EFF")
        calendar.appearance.selectionColor = UIColor(hex: "#F6C98EFF")
        calendar.appearance.titlePlaceholderColor = UIColor(hex: "#404040FF")
        calendar.appearance.titleDefaultColor = UIColor(hex: "#F59268FF")
        calendar.appearance.titleTodayColor = UIColor(hex: "#F59268FF")
        calendar.appearance.titleSelectionColor = UIColor(hex: "#3D1615FF")
        calendar.backgroundColor = .clear
        return calendar
    }()

    lazy var image: UIImageView = {
       let img = UIImageView()
        img .backgroundColor = UIColor(hex: "#FAE7D7FF")
        return img
    }()
    
    
    lazy var tableViewHeader: UIView = {
        let vi = UIView(frame: CGRect(x: 0, y: 0, width: CFWidth, height: 50.fit))
        let button = UIButton()
        //button.setImage(UIImage(named: "shop_star_selected"), for: .normal)
        button.setImage(UIImage(named: "double arrow"), for: .normal)
        vi.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10.fit)
            make.width.height.equalTo(30.fit)
        }
        button.addTarget(self, action: #selector(loadNext), for: .touchUpInside)
        vi.backgroundColor = .white
        return vi
    }()
    @objc func loadNext() {
        if self.calendar.scope == .month {
            self.calendar.setScope(.week, animated: true)
        } else {
            self.calendar.setScope(.month, animated: true)
        }
    }
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
         tableview.delegate = self
         tableview.dataSource = self
         tableview.showsVerticalScrollIndicator = false
         tableview.separatorStyle = .none
         tableview.register(CalendarCollectionViewCell.classForCoder(), forCellReuseIdentifier: "reusedcell")
        tableview.register(CalendarHeaderViewCell.self, forHeaderFooterViewReuseIdentifier: "cell")
        tableview.tableHeaderView = tableViewHeader
        tableview.backgroundColor = .clear
         return tableview
    }()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.view.backgroundColor  = .white//UIColor(hex: "#FAE7D7FF")
        self.view.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.right.left.equalTo(view)
            make.top.equalTo(view)
            make.height.equalTo(500.fit + kNavBarAndStatusBarHeight)
        }
        self.view.addSubview(calendar)
        calendar.snp.makeConstraints { (make) in
            make.right.left.equalTo(view)
            make.top.equalTo(self.navigation.bar.snp.bottom).offset(5.fit)
            make.height.equalTo(300.fit)
        }
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
          //  make.height.equalTo(100.fit)
            make.right.left.equalTo(view)
            make.top.equalTo(calendar.snp.bottom).offset(5.fit)
            make.bottom.equalTo(view)
        }
        DispatchQueue.main.async {
            self.tableViewHeader.corner(byRoundingCorners: [.topRight,.topLeft], radii: 35.fit)
        }
        configCalendar()
    }
    
    func configCalendar() {
        self.calendar.select(Date())
               
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.calendar.scope = .month
               
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
    }
    
    func configNavbar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        
        self.navigation.item.title = "日历"
    }
    
    // MARK:- UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
    

}

extension CalendarViewController: FSCalendarDataSource,FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
        }
        //self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
}


extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusedcell") as! CalendarCollectionViewCell
        //cell.foodImageView.image = UIImage(named: "素食拼盘")
        switch indexPath.row
        {
        case 0:
            cell.title.text = "早餐"
            //cell.updateUI(with: data[0])
        case 1:
            cell.title.text = "中餐"
            cell.label.text = "12:30 AM"
            //cell.updateUI(with: data[1])
        default:
            cell.title.text = "晚餐"
            cell.label.text = "17:30 PM"
            //cell.updateUI(with: data[2])
        }
        return cell
    }
    

    // MARK:- UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.fit
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220.fit
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "cell") as! CalendarHeaderViewCell
        headerView.cornerRadius = 40.fit
        headerView.alpha = 1
        return headerView
    }

}

