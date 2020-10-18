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
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        let itemViewController = ItemController(collectionViewLayout: layout)

        itemViewController.category = CategoryModel(name: "", number: "0", subcategories: [], isLeaf: false)
        let navController =  UINavigationController(rootViewController: itemViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
