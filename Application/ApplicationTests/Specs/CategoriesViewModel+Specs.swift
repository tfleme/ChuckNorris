//
//  CategoriesViewModel+Specs.swift
//  ApplicationTests
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxRelay

@testable import ChuckNorris
@testable import Domain

final class CategoriesViewModel_Specs: QuickSpec {

    override func spec() {
        describe("CategoriesViewModel") {
            
            let categories: [JokeCategory] = ["food", "science", "politics"]
            var viewModel: CategoriesViewModel!
            var useCases: ChuckNorrisCategoriesUseCasesStub!
            var disposeBag: DisposeBag!
            
            beforeEach {
                disposeBag = DisposeBag()
            }
            
            context("When itemSelected accepts IndexPath(0, 0)") {
                it("accepts food as JokeCategory") {
                    useCases = ChuckNorrisCategoriesUseCasesStub(resultType: .success, categories: categories)
                    viewModel = CategoriesViewModel(useCases: useCases)
                    
                    let selectedCategory = BehaviorRelay<JokeCategory?>(value: nil)
                    viewModel.selectedCategory.bind(to: selectedCategory).disposed(by: disposeBag)
                    
                    viewModel.viewDidAppear.accept(())
                    viewModel.itemSelected.accept(IndexPath(row: 0, section: 0))
                    
                    expect(selectedCategory.value!) == categories[0]
                }
            }
            
            context("When itemSelected accepts IndexPath(4, 0) which is out of bounds of the categories array") {
                it("doesn't accept any value") {
                    useCases = ChuckNorrisCategoriesUseCasesStub(resultType: .success, categories: categories)
                    viewModel = CategoriesViewModel(useCases: useCases)
                    
                    let selectedCategory = BehaviorRelay<JokeCategory?>(value: nil)
                    viewModel.selectedCategory.bind(to: selectedCategory).disposed(by: disposeBag)
                    
                    viewModel.viewDidAppear.accept(())
                    viewModel.itemSelected.accept(IndexPath(row: 4, section: 0))
                    
                    expect(selectedCategory.value).to(beNil())
                }
            }
            
            context("When categories fetching fails") {
                it("accepts an AlertViewModel on alert relay") {
                    
                    useCases = ChuckNorrisCategoriesUseCasesStub(resultType: .failure, categories: categories)
                    viewModel = CategoriesViewModel(useCases: useCases)
                    
                    let alertViewModel = BehaviorRelay<AlertViewModel?>(value: nil)
                    viewModel.alert.bind(to: alertViewModel).disposed(by: disposeBag)
                    
                    viewModel.viewDidAppear.accept(())
                    
                    expect(alertViewModel.value).notTo(beNil())
                }
            }
        }
        
        describe("memory leak") {
            
            let useCases = ChuckNorrisCategoriesUseCasesStub(
                resultType: .success,
                categories: [
                    "food",
                    "science",
                    "politics"
                ])
            let viewModel = CategoriesViewModel(useCases: useCases)
            var viewController: CategoriesViewController? = CategoriesViewController(viewModel: viewModel)
            weak var weakViewModelReference = viewModel
            
            context("when CategoriesViewModel is pushed and then popped from a navigation controller") {
                it("it should be nil when \(viewController!.self) is nil") {
                    
                    viewController = nil
                    expect(weakViewModelReference).to(beNil())
                }
            }
        }
    }
}
