//
//  AppDelegate.swift
//  ShoppingCart
//
//  Created by Jose Gustavo Rodriguez Baldera on 6/5/14.
//  Copyright (c) 2014 Jose Gustavo Rodriguez Baldera. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    var tabBarController: UITabBarController?
    var databasePath: String?
    let databaseName: String = "shopping.db"


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let documentDir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        self.databasePath = documentDir.stringByAppendingPathComponent(self.databaseName)
        
        self.createAndCheckDatabase() // setup the database
        
        // Override point for customization after application launch.
        let productsViewController = ProductsViewController(nibName: "ProductsViewController", bundle: nil)
        let productsNavViewController = UINavigationController(rootViewController: productsViewController)
        let tabControllers = [productsNavViewController];
        
        self.tabBarController = UITabBarController()
        self.tabBarController!.setViewControllers(tabControllers, animated: false)
        self.tabBarController!.selectedIndex = 0
        
        self.window!.rootViewController = self.tabBarController
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // #pragma mark - Database utilities methods
    
    func createAndCheckDatabase()
    {
        var success: Bool;
        
        let fileManager = NSFileManager.defaultManager()
        success = fileManager.fileExistsAtPath(self.databasePath)
        
        if success{return}
        
        let databasePathFromApp = NSBundle.mainBundle().resourcePath.stringByAppendingPathComponent(self.databaseName)
        
        if fileManager.copyItemAtPath(databasePathFromApp, toPath: self.databasePath, error: nil)
        {
            self.addSkipBackupAttributeToItemAtURL()
        }
        
    }
    
    func addSkipBackupAttributeToItemAtURL() -> Bool
    {
        let url = NSURL(fileURLWithPath: self.databasePath)
        var error: NSError?
        var success = url.setResourceValue(NSNumber.numberWithBool(true), forKey: NSURLIsExcludedFromBackupKey, error: &error)
        
        if !success
        {
            NSLog("Error excluding %@ from backup %@", url.lastPathComponent, error!)
        }
        return success;
    }
    
    // #pragma mark - TabBar customization
    
    func updateCartTabBadge()
    {
        let total: Int = Cart.totalProducts()
        let cartTab: UITabBarItem = self.tabBarController!.tabBar.items[1] as UITabBarItem
        
        if total > 0
        {
            cartTab.badgeValue = "\(total)"
        }
        else
        {
            cartTab.badgeValue = nil
        }
    }

}

