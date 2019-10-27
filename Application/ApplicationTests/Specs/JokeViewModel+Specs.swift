//
//  JokeViewModel+Specs.swift
//  ApplicationTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxRelay

@testable import ChuckNorris
@testable import Domain

final class JokeViewModel_Specs: QuickSpec {
    
    override func spec() {
        describe("JokeViewModel") {
            
            let jokeCategory: JokeCategory = "food"
            var viewModel: JokeViewModel!
            var useCases: ChuckNorrisJokeUseCasesStub!
            var disposeBag: DisposeBag!
            
            beforeEach {
                disposeBag = DisposeBag()
            }
            
            context("when viewDidAppear accepts an void event") {
                it("viewModel is setup") {
                    useCases = ChuckNorrisJokeUseCasesStub(resultType: .success)
                    viewModel = JokeViewModel(jokeCategory: jokeCategory, useCases: useCases)
                    
                    let title = BehaviorRelay<String>(value: "")
                    let imageData = BehaviorRelay<Data?>(value: Data())
                    let description = BehaviorRelay<String>(value: "")
                    
                    viewModel.title.bind(to: title).disposed(by: disposeBag)
                    viewModel.imageData.bind(to: imageData).disposed(by: disposeBag)
                    viewModel.description.bind(to: description).disposed(by: disposeBag)
                    
                    viewModel.viewDidAppear.accept(())
                    
                    expect(title.value) == jokeCategory.capitalized(with: Locale(identifier: "En"))
                    expect(imageData.value) == useCases.mockedImageData
                    expect(description.value) == useCases.mockedJoke.value
                }
            }
            
            context("when actionButtonTap accepts an void event") {
                it("viewModel is setup") {
                    useCases = ChuckNorrisJokeUseCasesStub(resultType: .success)
                    viewModel = JokeViewModel(jokeCategory: jokeCategory, useCases: useCases)
                    
                    let title = BehaviorRelay<String>(value: "")
                    let imageData = BehaviorRelay<Data?>(value: Data())
                    let description = BehaviorRelay<String>(value: "")
                    
                    viewModel.title.bind(to: title).disposed(by: disposeBag)
                    viewModel.imageData.bind(to: imageData).disposed(by: disposeBag)
                    viewModel.description.bind(to: description).disposed(by: disposeBag)
                    
                    viewModel.actionButtonTap.accept(())
                    
                    expect(title.value) == jokeCategory.capitalized(with: Locale(identifier: "En"))
                    expect(imageData.value) == useCases.mockedImageData
                    expect(description.value) == useCases.mockedJoke.value
                }
            }
            
            context("when joke fetching fails") {
                it("accepts an AlertViewModel on alert relay") {
                    
                    useCases = ChuckNorrisJokeUseCasesStub(resultType: .failure)
                    viewModel = JokeViewModel(jokeCategory: jokeCategory, useCases: useCases)
                    
                    let alertViewModel = BehaviorRelay<AlertViewModel?>(value: nil)
                    viewModel.alert.bind(to: alertViewModel).disposed(by: disposeBag)
                    
                    viewModel.viewDidAppear.accept(())
                    
                    expect(alertViewModel.value).notTo(beNil())
                }
            }
        }
        
        describe("memory leak") {
            
            let viewModel = JokeViewModel(
                jokeCategory: "food",
                useCases: ChuckNorrisJokeUseCasesStub(resultType: .success))
            var viewController: JokeViewController? = JokeViewController(viewModel: viewModel)
            weak var weakViewModelReference = viewModel
            
            context("when JokeViewModel is pushed and then popped from a navigation controller") {
                it("it should be nil when \(viewController!.self) is nil") {
                    
                    viewController = nil
                    expect(weakViewModelReference).to(beNil())
                }
            }
        }
    }
}
