//
//  AppDelegate.swift
//  Application
//
//  Created by Tiago Leme on 08/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private var appCoordinator: AppStartCoordinator!

}
    
//-----------------------------------------------------------------------------
// MARK: - UIApplicationDelegate
//-----------------------------------------------------------------------------

extension AppDelegate {
        
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appCoordinator = AppStartCoordinator(window: UIWindow(frame: UIScreen.main.bounds))
        
        return true
    }
}
