//
//  SuccessDependencyContainer.swift
//  ApplicationTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

@testable import Domain

struct JokesDependencyContainer: ChuckNorrisCategoriesUseCasesFactory, ChuckNorrisJokeUseCasesFactory {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let chuckNorrisCategoriesUseCasesResultType: ChuckNorrisCategoriesUseCasesStub.ResultType
    private let chuckNorrisJokeUseCasesResultType: ChuckNorrisJokeUseCasesStub.ResultType
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(chuckNorrisCategoriesUseCasesResultType: ChuckNorrisCategoriesUseCasesStub.ResultType,
         chuckNorrisJokeUseCasesResultType: ChuckNorrisJokeUseCasesStub.ResultType) {
        
        self.chuckNorrisCategoriesUseCasesResultType = chuckNorrisCategoriesUseCasesResultType
        self.chuckNorrisJokeUseCasesResultType = chuckNorrisJokeUseCasesResultType
    }
        
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    public var chuckNorrisCategoriesUseCases: ChuckNorrisCategoriesUseCasesType {
        return ChuckNorrisCategoriesUseCasesStub(
            resultType: chuckNorrisCategoriesUseCasesResultType,
            categories: [
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
        )
    }
    
    public var chuckNorrisJokeUseCases: ChuckNorrisJokeUseCasesType {
        return ChuckNorrisJokeUseCasesStub(resultType: chuckNorrisJokeUseCasesResultType)
    }
}
