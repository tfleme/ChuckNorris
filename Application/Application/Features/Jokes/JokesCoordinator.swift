//
//  JokesCoordinator.swift
//  Application
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import Domain

final class JokesCoordinator: BaseCoordinator {
    
    //-----------------------------------------------------------------------------
    // MARK: - Factory
    //-----------------------------------------------------------------------------
    
    typealias Factory = ChuckNorrisCategoriesUseCasesFactory & ChuckNorrisJokeUseCasesFactory
    
    //-----------------------------------------------------------------------------
    // MARK: - Coordinator
    //-----------------------------------------------------------------------------
    
    override var firstViewController: UIViewController { return viewController }
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let disposeBag = DisposeBag()
    
    private let factory: Factory
    
    private lazy var viewController: UIViewController = {
        
        let viewModel = CategoriesViewModel(useCases: factory.chuckNorrisCategoriesUseCases)
        
        viewModel.selectedCategory
            .subscribe(onNext: { jokeCategory in
                self.pushJokeViewController(with: jokeCategory)
            })
            .disposed(by: disposeBag)
        
        return CategoriesViewController(viewModel: viewModel)
    }()
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(navigationController: UINavigationController?, factory: Factory) {
        
        self.factory = factory
        
        super.init(navigationController: navigationController)
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods
//-----------------------------------------------------------------------------

extension JokesCoordinator {
 
    private func pushJokeViewController(with jokeCategory: JokeCategory) {
        
        let viewModel = JokeViewModel(jokeCategory: jokeCategory, useCases: factory.chuckNorrisJokeUseCases)
        
        viewModel.dismiss
            .subscribe(onNext: {
                self.popViewController()
            })
            .disposed(by: disposeBag)
        
        viewModel.activityURL
            .subscribe(onNext: { url in
                self.presentActivityViewController(with: url)
            })
            .disposed(by: disposeBag)
        
        push(JokeViewController(viewModel: viewModel))
    }
    
    private func presentActivityViewController(with url: URL) {
        
        let viewController = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil)
        
        if UIDevice.current.userInterfaceIdiom == .pad,
            let sourceView = navigationController?.viewControllers.last?.view,
            let popoverPresentationController = viewController.popoverPresentationController {
            
            #warning("Tiago Leme: Fix iPad popover presentation")
            popoverPresentationController.sourceView = sourceView
        }
        
        present(viewController)
    }
}
