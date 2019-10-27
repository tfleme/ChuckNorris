//
//  JokesKIFUITests.swift
//  ApplicationUITests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import KIF

@testable import ChuckNorris
@testable import Domain

final class JokesCoordinatorUITests: KIFTestCase {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------

    private let window = UIWindow(frame: UIScreen.main.bounds)
    
    private var tester: KIFUITestActor!
    private var navigationController: UINavigationController!
    private var coordinator: JokesCoordinator!
    
    //-----------------------------------------------------------------------------
    // MARK: - Setup
    //-----------------------------------------------------------------------------
    
    override func setUp() {
        super.setUp()
        
        KIFEnableAccessibility()
        
        tester = KIFUITestActor(file: #file, line: #line, delegate: self)
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------------
    
    func testJokeCoordinatorSuccess() {
        
        configureTests(with: JokesDependencyContainer(
            chuckNorrisCategoriesUseCasesResultType: .success,
            chuckNorrisJokeUseCasesResultType: .success))

        /// CategoriesViewController
        
        tester?.waitForView(withAccessibilityLabel: "CategoriesViewController.view")
        let tableView = tester?.waitForView(withAccessibilityLabel: "CategoriesViewController.tableView") as? UITableView
        tester?.tapRow(at: IndexPath(row: 5, section: 0), in: tableView!)
        
        /// JokeViewController
        
        tester?.waitForView(withAccessibilityLabel: "JokeViewController.description")
        tester?.waitForView(withAccessibilityLabel: "JokeViewController.imageView")
        
        tester?.waitForView(withAccessibilityLabel: "JokeViewController.actionButton")
        tester?.tapView(withAccessibilityLabel: "JokeViewController.actionButton")
        
        tester?.waitForView(withAccessibilityLabel: "JokeViewController.description")
        tester?.waitForView(withAccessibilityLabel: "JokeViewController.imageView")
        
        tester?.tapView(withAccessibilityLabel: "JokeViewController.activityButton")
        tester?.wait(forTimeInterval: 1.0)
    }
    
    func testJokeCoordinatorFailureFetchingCategories() {
        
        configureTests(with: JokesDependencyContainer(
             chuckNorrisCategoriesUseCasesResultType: .failure,
             chuckNorrisJokeUseCasesResultType: .success))
        
        /// CategoriesViewController
        
        tester?.waitForView(withAccessibilityLabel: "CategoriesViewController.view")
        
        /// AlertViewController
        
        tester?.waitForView(withAccessibilityLabel: "AlertViewController.actionButton")
        tester?.tapView(withAccessibilityLabel: "AlertViewController.actionButton")
        
        /// CategoriesViewController
        
        tester?.waitForView(withAccessibilityLabel: "CategoriesViewController.view")
    }
    
    func testJokeCoordinatorFailureFetchingJoke() {
        
        configureTests(with: JokesDependencyContainer(
            chuckNorrisCategoriesUseCasesResultType: .success,
            chuckNorrisJokeUseCasesResultType: .failure))

        /// CategoriesViewController
        
        tester?.waitForView(withAccessibilityLabel: "CategoriesViewController.view")
        let tableView = tester?.waitForView(withAccessibilityLabel: "CategoriesViewController.tableView") as? UITableView
        tester?.tapRow(at: IndexPath(row: 5, section: 0), in: tableView!)
        
        /// AlertViewController
        
        tester?.waitForView(withAccessibilityLabel: "AlertViewController.actionButton")
        tester?.tapView(withAccessibilityLabel: "AlertViewController.actionButton")
        
        /// CategoriesViewController
        
        tester?.waitForView(withAccessibilityLabel: "CategoriesViewController.view")
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods
//-----------------------------------------------------------------------------

extension JokesCoordinatorUITests {
    
    private func configureTests(with factory: JokesCoordinator.Factory) {
        
        navigationController = UINavigationController()
        coordinator = JokesCoordinator(navigationController: navigationController, factory: factory)
        
        navigationController.pushCoordinator(coordinator)
        navigationController.view.frame = window.bounds
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
