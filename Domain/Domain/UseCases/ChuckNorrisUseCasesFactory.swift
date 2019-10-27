//
//  ChuckNorrisUseCasesFactory.swift
//  Domain
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation
import Services

public protocol ChuckNorrisCategoriesUseCasesFactory {
    var chuckNorrisCategoriesUseCases: ChuckNorrisCategoriesUseCasesType { get }
}
    
public protocol ChuckNorrisJokeUseCasesFactory {
    var chuckNorrisJokeUseCases: ChuckNorrisJokeUseCasesType { get }
}

extension DependencyContainer: ChuckNorrisCategoriesUseCasesFactory, ChuckNorrisJokeUseCasesFactory {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
   
    private var chuckNorriesUseCases: ChuckNorrisUseCases {
        return ChuckNorrisUseCases(
            services: servicesFactory.chuckNorrisServices,
            imageFetcherServices: servicesFactory.imageFetcherServices)
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    public var chuckNorrisCategoriesUseCases: ChuckNorrisCategoriesUseCasesType {
        return chuckNorriesUseCases
    }
    
    public var chuckNorrisJokeUseCases: ChuckNorrisJokeUseCasesType {
        return chuckNorriesUseCases
    }
}
