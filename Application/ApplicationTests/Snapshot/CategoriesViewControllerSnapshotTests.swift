//
//  CategoriesViewControllerSnapshotTests.swift
//  ApplicationTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import FBSnapshotTestCase

@testable import ChuckNorris
@testable import Domain

final class CategoriesViewControllerSnapshotTests: FBSnapshotTestCase {
    
    //-----------------------------------------------------------------------------
    // MARK: - Setup
    //-----------------------------------------------------------------------------
    
    override func setUp() {
        super.setUp()
        
        recordMode = false
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private var categoriesViewController: UIViewController {
        
        let categories: [JokeCategory] = [
                "animal",
                "career",
                "celebrity",
                "dev",
                "explicit",
                "fashion",
                "food",
                "history",
                "money",
                "movie",
                "music",
                "political",
                "religion",
                "science",
                "sport",
                "travel"
        ]
        
        let useCases = ChuckNorrisCategoriesUseCasesStub(resultType: .success, categories: categories)
        let viewModel = CategoriesViewModel(useCases: useCases)
        
        return  UINavigationController(rootViewController: CategoriesViewController(viewModel: viewModel))
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------------
    
    func testLightMode() {
        
        for screen in ScreenSizes.allCases {
            let window = UIWindow(frame: CGRect(origin: CGPoint.zero, size: screen.size))
            
            if #available(iOS 13.0, *) {
                window.overrideUserInterfaceStyle = .light
            }
            
            let viewController = categoriesViewController
            viewController.view.frame = window.bounds
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            
            let exp = expectation(description: "Test after 0.3 seconds")
            _ = XCTWaiter.wait(for: [exp], timeout: 0.3)
            
            let id = "\(screen)"
            FBSnapshotVerifyView(viewController.view, identifier: id)
        }
    }
    
    func testDarkMode() {
        
        for screen in ScreenSizes.allCases {
            let window = UIWindow(frame: CGRect(origin: CGPoint.zero, size: screen.size))
            
            if #available(iOS 13.0, *) {
                window.overrideUserInterfaceStyle = .dark
            }
            
            let viewController = categoriesViewController
            viewController.view.frame = window.bounds
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            
            let exp = expectation(description: "Test after 0.3 seconds")
            _ = XCTWaiter.wait(for: [exp], timeout: 0.3)
            
            let id = "\(screen)"
            FBSnapshotVerifyView(viewController.view, identifier: id)
        }
    }
}


