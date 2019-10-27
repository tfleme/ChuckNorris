//
//  ChuckNorrisCategoriesUseCasesStub.swift
//  ApplicationTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

@testable import Domain

struct ChuckNorrisCategoriesUseCasesStub: ChuckNorrisCategoriesUseCasesType {

    enum ResultType {
        case success
        case failure
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let resultType: ResultType
    private let categories: [JokeCategory]
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(resultType: ResultType, categories: [JokeCategory]) {
        
        self.resultType = resultType
        self.categories = categories
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------------
    
    func categories(completion: @escaping (Result<[JokeCategory], ViewModelError>) -> Void) {
        
        switch resultType {
        case .success:
            completion(.success(categories))
        case .failure:
            completion(.failure(ViewModelError(.generic)))
        }
    }
}
