//
//  JokeViewControllerSnapshotTests.swift
//  ApplicationTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import FBSnapshotTestCase

@testable import ChuckNorris
@testable import Domain

final class JokeViewControllerSnapshotTests: FBSnapshotTestCase {
    
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
    
    private var jokeViewController: UIViewController {
        
        let jokeCategory: JokeCategory = "food"
        let viewModel = JokeViewModel(
            jokeCategory: jokeCategory,
            useCases: ChuckNorrisJokeUseCasesStub(resultType: .success))
        
        return  UINavigationController(rootViewController: JokeViewController(viewModel: viewModel))
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
            
            let viewController = jokeViewController
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
            
            let viewController = jokeViewController
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

