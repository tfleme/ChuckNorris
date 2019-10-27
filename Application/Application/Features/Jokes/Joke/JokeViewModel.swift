//
//  JokeViewModel.swift
//  Application
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import Domain

final class JokeViewModel {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let disposeBag = DisposeBag()
    
    private let jokeCategory: JokeCategory
    private let useCases: ChuckNorrisJokeUseCasesType
    
    private var jokeURL: URL?
    
    //-----------------------------------------------------------------------------
    // MARK: - Output relays
    //-----------------------------------------------------------------------------
    
    let dismiss = PublishRelay<Void>()
    let activityURL = PublishRelay<URL>()
    
    //-----------------------------------------------------------------------------
    // MARK: - Input relays
    //-----------------------------------------------------------------------------
    
    let isLoading = PublishRelay<Bool>()
    let isImageLoading = PublishRelay<Bool>()
    let alert = PublishRelay<AlertViewModel>()
    
    let title: BehaviorRelay<String>
    let imageData = PublishRelay<Data?>()
    let description = PublishRelay<String>()
    let isActivityButtonEnabled = BehaviorRelay<Bool>(value: false)
    
    let viewDidAppear = PublishRelay<Void>()
    let actionButtonTap = PublishRelay<Void>()
    let activityButtonTap = PublishRelay<Void>()
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(jokeCategory: JokeCategory, useCases: ChuckNorrisJokeUseCasesType) {
        
        self.jokeCategory = jokeCategory
        self.useCases = useCases
        
        self.title = BehaviorRelay<String>(value: jokeCategory.capitalized(with: Locale(identifier: "En")))
        
        bind()
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Binding
//-----------------------------------------------------------------------------

extension JokeViewModel {
    
    private func bind() {
        
        viewDidAppear
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                
                self.fetchJoke(from: self.jokeCategory)
            })
            .disposed(by: disposeBag)
        
        actionButtonTap
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                
                self.fetchJoke(from: self.jokeCategory)
            })
            .disposed(by: disposeBag)
        
        activityButtonTap
            .subscribe(onNext: { [weak self] in
                guard let `self` = self, let url = self.jokeURL else { return }
                
                self.activityURL.accept(url)
            })
            .disposed(by: disposeBag)
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Setup
//-----------------------------------------------------------------------------

extension JokeViewModel {
    
    private func setup(with joke: Joke) {
     
        description.accept(joke.value)
        
        jokeURL = URL(string: joke.urlString)
        isActivityButtonEnabled.accept(jokeURL != nil)
        
        fetchImageData(withURLString: joke.iconUrlString)
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods
//-----------------------------------------------------------------------------

extension JokeViewModel {
    
    private func fetchJoke(from jokeCategory: JokeCategory) {
        
        isLoading.accept(true)
     
        useCases.joke(from: jokeCategory) { [weak self] result in
            
            self?.isLoading.accept(false)
            
            switch result {
            case .success(let joke):
                self?.setup(with: joke)
            case .failure(let error):
                
                let alertViewModel = AlertViewModel(
                    viewModelError: error,
                    actionButtonTitle: "DISMISS",
                    actionButtonTapHandler: { [weak self] in
                        self?.dismiss.accept(())
                    })
                
                self?.alert.accept(alertViewModel)
            }
        }
    }
    
    private func fetchImageData(withURLString urlString: String) {
        
        isImageLoading.accept(true)
        
        useCases.imageData(withURLString: urlString) { [weak self] result in
            
            self?.isImageLoading.accept(false)
            
            switch result {
            case .success(let imageData):
                self?.imageData.accept(imageData)
            case .failure:
                self?.imageData.accept(nil)
            }
        }
    }
}
