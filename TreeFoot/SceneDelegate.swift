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
           let archiveVC = ArchiveViewController()
           let mineVC = MineViewController()
           homeVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
           recoderVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
           archiveVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
           mineVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))

           let homeNav = MainNavigationController.init(rootViewController: homeVC)
           let recoderNav = MainNavigationController.init(rootViewController: recoderVC)
           let archiveNav = MainNavigationController.init(rootViewController: archiveVC)
           let mineNav = MainNavigationController.init(rootViewController: mineVC)
           
           homeNav.navigation.configuration.isEnabled = true
           recoderNav.navigation.configuration.isEnabled = true
           archiveNav.navigation.configuration.isEnabled = true
           mineNav.navigation.configuration.isEnabled = true
           
           //diaryNav.navigation.configuration.barTintColor = .white
           
           if homeNav.children.count > 1 {
               
           }
           
           let tabBarController = ESTabBarController()
           
           tabBarController.viewControllers = [homeNav,recoderNav, archiveNav,mineNav]
           tabBarController.tabBar.backgroundColor = .white
           //tabBarController.tabBar.shadowImage = UIImage(named: "background")
           
           tabBarController.tabBar.backgroundImage = UIImage(named: "background")
           return tabBarController
       }


}

