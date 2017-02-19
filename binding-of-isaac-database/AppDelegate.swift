//
//  AppDelegate.swift
//  binding-of-isaac-database
//
//  Created by Craig Holliday on 12/18/16.
//  Copyright © 2016 Craig Holliday. All rights reserved.
//

import UIKit
import RealmSwift
import CoreSpotlight
import SwiftyBeaver
let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Setup swifty beaver
        let console = ConsoleDestination()
        log.addDestination(console) // add to SwiftyBeaver
        
        // Setup realm configuration
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        
        Realm.Configuration.defaultConfiguration = config

        DataSource.loadItems() { (success) -> Void in }
        
        // Set bar back button to just be chevron icon
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for: UIBarMetrics.default)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if userActivity.activityType == CSSearchableItemActionType {
            if let uniqueIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String {
                let realm = try! Realm()
                let spotlightItem = realm.object(ofType: ItemModel.self, forPrimaryKey: uniqueIdentifier)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let vc = storyboard.instantiateViewController(withIdentifier: "ItemDetailViewController") as? ItemDetailViewController {
                    
                    vc.selectedItem = spotlightItem
                    vc.isFromSpotlight = true
                    
                    if var topController = UIApplication.shared.keyWindow?.rootViewController {
                        while let presentedViewController = topController.presentedViewController {
                            topController = presentedViewController
                        }
                        let navController = UINavigationController(rootViewController: vc)
                        
                        topController.present(navController, animated: true, completion: nil)
                    }
                }
            }
        }
        
        return true
    }
}
