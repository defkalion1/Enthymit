//
//  AppDelegate.swift
//  Enthymit
//
//  Created by Defkalion on 11/02/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
//        let myName = HealthData()
//       myName.name = "Constantine Defkalion"
        
       
        do {
            _ = try Realm()
//            try realm.write {
//                realm.add(myName)
//            }
        }catch {
            print("Error Installing new Realm\(error)")
        }
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
    }

}

