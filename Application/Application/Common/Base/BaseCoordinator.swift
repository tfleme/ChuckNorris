//
//  BaseCoordinator.swift
//  Application
//
//  Created by Tiago Leme on 08/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit

protocol CoordinatorType {
    var firstViewController: UIViewController { get }
}

class BaseCoordinator: CoordinatorType {
    
    //-----------------------------------------------------------------------------
    // MARK: - Coordinator
    //-----------------------------------------------------------------------------
    
    var firstViewController: UIViewController { fatalError("'firstViewController' not implemented") }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    let navigationController: UINavigationController?
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

//-----------------------------------------------------------------------------
// MARK: - Public methods - Navigation
//-----------------------------------------------------------------------------

extension BaseCoordinator {
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func push(_ coordinator: BaseCoordinator, animated: Bool = true) {
        navigationController?.pushCoordinator(coordinator, animated: animated)
    }
    
    func popViewController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToViewController(_ viewController: UIViewController, animated: Bool = true) {
        
        navigationController?.popToViewController(viewController, animated: animated)
        navigationController?.presentedViewController?.dismiss(animated: animated)
    }
    
    func popCoordinator(animated: Bool = true) {
        
        navigationController?.popToViewController(firstViewController, animated: false)
        navigationController?.popViewController(animated: animated)
    }
}

//-----------------------------------------------------------------------------
// MARK: - Public methods - Presenting
//-----------------------------------------------------------------------------

extension BaseCoordinator {
    
    func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.present(viewController, animated: animated, completion: completion)
    }
    
    func present(_ coordinator: BaseCoordinator, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.present(coordinator.firstViewController, animated: animated, completion: completion)
    }
    
    func dismissViewController(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
}
