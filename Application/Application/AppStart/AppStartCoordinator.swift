//
//  AppStartCoordinator.swift
//  Application
//
//  Created by Tiago Leme on 08/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//


import UIKit
import Domain

final class AppStartCoordinator {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private var onboardingCoordinator: OnboardingCoordinator!
    private var navigationController: UINavigationController
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    let window: UIWindow
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(window: UIWindow) {
        
        self.window = window

        navigationController = UINavigationController()
        onboardingCoordinator = OnboardingCoordinator(
            navigationController: navigationController,
            factory: Domain.DependencyContainer())
        navigationController.pushViewController(onboardingCoordinator.firstViewController, animated: false)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
