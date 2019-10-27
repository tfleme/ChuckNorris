//
//  OnboardingCoordinator.swift
//  Application
//
//  Created by Tiago Leme on 08/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import Domain

final class OnboardingCoordinator: BaseCoordinator {
    
    //-----------------------------------------------------------------------------
    // MARK: - Factory
    //-----------------------------------------------------------------------------
    
    typealias Factory = JokesCoordinator.Factory
    
    //-----------------------------------------------------------------------------
    // MARK: - Coordinator
    //-----------------------------------------------------------------------------
    
    override var firstViewController: UIViewController { return viewController }
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let factory: Factory
    
    private lazy var viewController: UIViewController = {
        
        let coordinator = JokesCoordinator(navigationController: navigationController, factory: factory)
        
        return coordinator.firstViewController
    }()
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(navigationController: UINavigationController?, factory: Factory) {
        
        self.factory = factory
        
        super.init(navigationController: navigationController)
    }
}
