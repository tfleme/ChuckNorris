//
//  CategoriesViewModel.swift
//  Application
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import Domain

final class CategoriesViewModel {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let disposeBag = DisposeBag()
    private let categories = BehaviorRelay<[JokeCategory]>(value: [])
    
    private let useCases: ChuckNorrisCategoriesUseCasesType
    
    //-----------------------------------------------------------------------------
    // MARK: - Output relays
    //-----------------------------------------------------------------------------
    
    let selectedCategory = PublishRelay<JokeCategory>()
    
    //-----------------------------------------------------------------------------
    // MARK: - Input relays
    //-----------------------------------------------------------------------------
    
    let isLoading = BehaviorRelay<Bool>(value: false)
    let alert = PublishRelay<AlertViewModel>()
    
    let categoryCellViewModels = BehaviorRelay<[CategoryCellViewModel]>(value: [])
    
    let viewDidAppear = PublishRelay<Void>()
    let itemSelected = PublishRelay<IndexPath>()
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(useCases: ChuckNorrisCategoriesUseCasesType) {
        
        self.useCases = useCases
        
        bind()
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Binding
//-----------------------------------------------------------------------------

extension CategoriesViewModel {
    
    private func bind() {
        
        categories
            .map { $0.map { CategoryCellViewModel(title: $0.capitalized(with: Locale(identifier: "En"))) } }
            .bind(to: categoryCellViewModels)
            .disposed(by: disposeBag)
        
        itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let `self` = self, self.categories.value.count > indexPath.row else { return }
            
                self.selectedCategory.accept(self.categories.value[indexPath.row])
            })
            .disposed(by: disposeBag)
        
        viewDidAppear
            .filter { [weak self] in self?.categories.value.isEmpty == true }
            .subscribe(onNext: { [weak self] in 
                self?.fetchCategories()
            })
            .disposed(by: disposeBag)
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods
//-----------------------------------------------------------------------------

extension CategoriesViewModel {
    
    private func fetchCategories() {
        
        isLoading.accept(true)
        
        useCases.categories { [weak self] result in
            
            self?.isLoading.accept(false)
            
            switch result {
            case .success(let categories):
                self?.categories.accept(categories)
            case .failure(let error):
                
                let alertViewModel = AlertViewModel(
                    title: error.title,
                    message: "We're having problems fetching somo joke categories",
                    actionButtonTitle: "TRY AGAIN",
                    actionButtonTapHandler: { [weak self] in
                        self?.fetchCategories()
                    })
                 
                 self?.alert.accept(alertViewModel)
            }
        }
    }
}
