//
//  AppDelegate.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 2/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let masterViewController = UINavigationController(rootViewController: CategoryController())
        let detailViewController = UINavigationController(rootViewController: ItemController())
        
        let splitViewController = UISplitViewController()
        splitViewController.delegate = self
        splitViewController.viewControllers = [masterViewController, detailViewController]
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

extension AppDelegate: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondary = secondaryViewController as? UINavigationController else { return false }
        guard let itemController = secondary.topViewController as? ItemController else { return false }
        if itemController.items.count == 0 {
            return true
        }
        return false
    }
}
