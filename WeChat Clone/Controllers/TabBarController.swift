//
//  TabBarController.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/14.
//

import UIKit

enum TabBarTitle {
    static let message = "微信"
    static let contacts = "通讯录"
    static let discovery = "发现"
    static let me = "我"
}

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    func setupTabBar() {
        if #available(iOS 13, *) {
            let appearance = UITabBarAppearance()
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .white
            
            appearance.stackedLayoutAppearance.normal.iconColor = .label
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
            //            appearance.stackedLayoutAppearance.normal.badgeBackgroundColor = .yellow
            
            appearance.stackedLayoutAppearance.selected.iconColor = .myGreen
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.myGreen]
            self.tabBar.standardAppearance = appearance
        } else {
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.myGreen], for: .selected)
            
            // give a bit padding between tabbar item title and image
            UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGray], for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemPink], for: .selected)
        }
        
        // set tabBar's sub viewController
        let vc1 = UINavigationController(rootViewController: MessageViewController())
        let vc2 = UINavigationController(rootViewController: ContactViewController())
        let vc3 = UINavigationController(rootViewController: DiscoveryViewController())
        let vc4 = UINavigationController(rootViewController: MeViewController())
        
        self.setViewControllers([vc1, vc2, vc3, vc4], animated: false)
        
        // configure tabBar item
        guard let items = self.tabBar.items else { return }
        items[0].title = TabBarTitle.message
        items[0].image = UIImage(systemName: "message")
        items[0].selectedImage = UIImage(systemName: "message.fill")
        
        items[1].title = TabBarTitle.contacts
        items[1].image = UIImage(systemName: "person.2")
        items[1].selectedImage = UIImage(systemName: "person.2.fill")
        
        items[2].title = TabBarTitle.discovery
        items[2].image = UIImage(named: "explore")
        items[2].selectedImage = UIImage(named: "explore.fill")
        
        items[3].title = TabBarTitle.contacts
        items[3].image = UIImage(systemName: "person")
        items[3].selectedImage = UIImage(systemName: "person.fill")
    }


}
