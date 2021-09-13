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
        
        view.backgroundColor = .systemBackground

        setupTabBar()
    }
    
    func setupTabBar() {
        let vc1 = UINavigationController(rootViewController: MessageViewController())
        let vc2 = UINavigationController(rootViewController: ContactViewController())
        let vc3 = UINavigationController(rootViewController: DiscoveryViewController())
        let vc4 = UINavigationController(rootViewController: MeViewController())
        
        // set navigationController title
        vc1.tabBarItem.title = TabBarTitle.message
        vc2.tabBarItem.title = TabBarTitle.contacts
        vc3.tabBarItem.title = TabBarTitle.discovery
        vc4.tabBarItem.title = TabBarTitle.me

        
        viewControllers = [vc1, vc2, vc3, vc4];
    }


}
