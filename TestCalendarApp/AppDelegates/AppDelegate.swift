//
//  AppDelegate.swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov  on 15/8/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppsSetting.instance.configureSettings()
        return true
    }
}

