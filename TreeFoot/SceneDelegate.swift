//
//  SceneDelegate.swift
//  TreeFoot
//
//  Created by zhangchi on 2020/9/15.
//  Copyright © 2020 Hut. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        configVC()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func configVC() {
        
        let mainTabVC = mainTabBarVC()
        self.window?.rootViewController = mainTabVC
        self.window?.makeKeyAndVisible()

    }
    
    func mainTabBarVC() -> ESTabBarController{

           let homeVC = HomeViewController()
           let recoderVC = RecoderViewController()
           let archiveVC = PageViewController()
           let mineVC = MineViewController()
           let addVC = UIViewController()
           homeVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
           recoderVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
           archiveVC.tabBarItem = ESTabBarItem.init(CFBouncesContentViewRight(), title: "", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
           mineVC.tabBarItem = ESTabBarItem.init(CFBouncesContentViewRight(), title: "", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))

           // addVC.tabBarItem = ESTabBarItem.init(CenterTabBarItem(), title: nil, image: UIImage(named: "addphoto_icon"), selectedImage: UIImage(named: "addphoto_icon"))

                let item  = ESTabBarItem.init(CFBouncesContentView(), title: "", image: UIImage(), selectedImage: UIImage())
        
                    addVC.tabBarItem = item
           let homeNav = MainNavigationController.init(rootViewController: homeVC)
           let recoderNav = MainNavigationController.init(rootViewController: recoderVC)
           let archiveNav = MainNavigationController.init(rootViewController: archiveVC)
           let mineNav = MainNavigationController.init(rootViewController: mineVC)
           let addNav = MainNavigationController(rootViewController: addVC)
            
          
        
           homeNav.navigation.configuration.isEnabled = true
           recoderNav.navigation.configuration.isEnabled = true
           archiveNav.navigation.configuration.isEnabled = true
           mineNav.navigation.configuration.isEnabled = true
        addNav.navigation.configuration.isEnabled = true
           //diaryNav.navigation.configuration.barTintColor = .white
           
           if homeNav.children.count > 1 {
               
           }
           
           let tabBarController = ESTabBarController()
           
        tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
                let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
                alertController.addAction(takePhotoAction)
                let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
                alertController.addAction(selectFromAlbumAction)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
//                let notesVC = AddViewController()
//                let noteNav = MainNavigationController(rootViewController: notesVC)
//                noteNav.navigation.configuration.isEnabled = true
//                noteNav.navigation.configuration.barTintColor = .white
//                noteNav.navigation.configuration.tintColor = .white
//                noteNav.modalPresentationStyle = .fullScreen
//                tabBarController?.present(noteNav, animated: true, completion: nil)
            }
        }
        
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = .white
        tabBarController.tabBar.barStyle = .default
        tabBarController.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarController.tabBar.layer.shadowOffset = CGSize(width: 0, height: -3.fit)
        tabBarController.tabBar.layer.shadowOpacity = 0.2
           tabBarController.viewControllers = [homeNav,recoderNav,addNav, archiveNav,mineNav]
           tabBarController.tabBar.backgroundColor = .white
           tabBarController.tabBar.shadowImage = UIImage(named: "background")
        tabBarController.tabBar.barTintColor = UIColor.red
           tabBarController.tabBar.backgroundImage = UIImage(named: "background")
           return tabBarController
       }


}

// 重写hitTest方法 响应tabbar 以外的点击事件
extension ESTabBar {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01 ){
            return nil
        }
        let resultView  = super.hitTest(point, with: event)
        if resultView != nil {
            return resultView
        } else {
            for subView in self.subviews.reversed() {
                let convertPoint : CGPoint = subView.convert(point, from: self)
                let hitView = subView.hitTest(convertPoint, with: event)
                if (hitView != nil) {
                    return hitView
                }
            }
        }
        return nil
    }
    
}

extension ESTabBarController {
}
