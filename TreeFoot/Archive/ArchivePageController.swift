//
//  ArchivePageController.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/23.
//  Copyright © 2020 Hut. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIViewController {
    
    lazy var image: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "apple")
        return image
    }()
    
    lazy var pageControl: UIPageControl = {
       let page = UIPageControl()
        page.backgroundColor = .clear
        page.numberOfPages = viewControllers.count
        page.currentPage = 0
        page.isEnabled = false
        page.currentPageIndicatorTintColor = UIColor(r: 245, g: 146, b: 104)
        page.pageIndicatorTintColor = UIColor(r: 224, g: 224, b: 224)
        return page
    }()
    
    
    // 懒加载创建UIPageViewController
    lazy var pageViewController: UIPageViewController = {
        // 设置水平滚动
        let pageVc = UIPageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal,
                                          options: nil)
        pageVc.dataSource = self
        pageVc.delegate = self
        // pageVc.view.backgroundColor = .orange
        return pageVc
    }()
    let leftVC = ArchiveViewController()
    let rightVC = ArchiveBodyViewController()
    let viewControllers = [ArchiveViewController(),ArchiveBodyViewController()]
    var leftFlag = true
    var rightFlag = false
    
    var index = 1
    var currentIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
                configUI()
        configNavbar()
        addPageViewController()

        // 设置初始化显示视图控制器
        pageViewController.setViewControllers([leftVC],
                                              direction: .forward,
                                              animated: false,
                                              completion: nil)

    }
    func configUI() {
        self.view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.97, alpha: 1)
    }
    
    func configNavbar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
    }
    
    func addPageViewController() {
        self.addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        view.addSubview(image)
        
        image.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(kStatusBarHeight)
            make.centerX.equalTo(view)
            make.height.equalTo(80.fit)
            make.width.equalTo(80.fit)
        }
        self.view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom).offset(20.fit)
            make.centerX.equalTo(view)
            make.height.equalTo(30.fit)
            make.width.equalTo(100.fit)
        }
        pageViewController.view.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom).offset( 10.fit)
            make.centerX.equalTo(view)
            make.height.equalTo(self.view.frame.size.height)
            make.width.equalTo(CFWidth)
        }
    }
    
    
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate,UIScrollViewDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        pageControl.currentPage = 0
        // 显示前一个页面，保证数组不越界
        if currentIndex - 1 >= 0 {
            currentIndex -= 1
            print(2,viewControllers[currentIndex])
            
            return leftVC
        }
        
        print("nil1")
        return nil
    }
    func presentationCount(for: UIPageViewController) -> Int {
        return 1
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        pageControl.currentPage = 1
        if rightFlag {
                    print("nil2")
            return nil
        }
        leftFlag = false
        rightFlag = true
        
        return rightVC
        // 显示后一个视图页面
        if currentIndex + 1 < viewControllers.count {
            currentIndex += 1
            print(1,viewControllers[currentIndex])

            return rightVC
        }

        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print("willTransition - 开始滚动")
    }
    

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if completed && finished {
            index += 1
                    print("didFinishAnimating - 结束滚动")
//                    let pageContentViewController = pageViewController.viewControllers![0] as! ArchiveBaseController
//                    let index = pageContentViewController.pageIndex
//                    pageControl.currentPage =  index
//                    print(index)
//                    print(pageViewController.viewControllers!.first!.view.tag,currentIndex)
        }
    }
    
    
}

//自定义视图控制器代理协议
protocol PageViewControllerDelegate: class {
    
    //当页面数量改变时调用
    func pageViewController(pageViewController: PageViewController,
                                    didUpdatePageCount count: Int)
    
    //当前页索引改变时调用
    func pageViewController(pageViewController: PageViewController,
                                    didUpdatePageIndex index: Int)
}
