//
//  ChuckNorrisUseCases.swift
//  Domain
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation
import Services

public protocol ChuckNorrisCategoriesUseCasesType {
    func categories(completion: @escaping (Result<[JokeCategory], ViewModelError>) -> Void)
}

public protocol ChuckNorrisJokeUseCasesType {
    func joke(from category: JokeCategory, completion: @escaping (Result<Joke, ViewModelError>) -> Void)
    func imageData(withURLString urlString: String, completion: @escaping (Result<Data, ViewModelError>) -> Void)
}

final class ChuckNorrisUseCases {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let services: ChuckNorrisServicesType
    private let imageFetcherServices: ImageFetcherServicesType
    
    //-----------------------------------------------------------------------------
    // MARK: - Initalization
    //-----------------------------------------------------------------------------
    
    init(services: ChuckNorrisServicesType, imageFetcherServices: ImageFetcherServicesType) {
        
        self.services = services
        self.imageFetcherServices = imageFetcherServices
    }
}

//-----------------------------------------------------------------------------
// MARK: - ChuckNorrisCategoriesUseCasesType
//-----------------------------------------------------------------------------

extension ChuckNorrisUseCases: ChuckNorrisCategoriesUseCasesType {
    
    public func categories(completion: @escaping (Result<[JokeCategory], ViewModelError>) -> Void) {
        
        services.fetchCategories { result in
            
            switch result {
            case .success(let data):
                guard let categories: [JokeCategory] = DecodableHelper.decode(data) else {
                    completion(.failure(ViewModelError(.parsing)))
                    return
                }
                
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(ViewModelError(error)))
            }
        }
    }
}

//-----------------------------------------------------------------------------
// MARK: - ChuckNorrisRandomJokeUseCasesType
//-----------------------------------------------------------------------------

extension ChuckNorrisUseCases: ChuckNorrisJokeUseCasesType {
    
    public func joke(from category: JokeCategory, completion: @escaping (Result<Joke, ViewModelError>) -> Void) {
        
        services.fetchJoke(fromCategoryString: category) { result in
            
            switch result {
            case .success(let data):
                guard let joke: Joke = DecodableHelper.decode(data) else {
                    completion(.failure(ViewModelError(.parsing)))
                    return
                }
                
                completion(.success(joke))
            case .failure(let error):
                completion(.failure(ViewModelError(error)))
            }
        }
    }
    
    func imageData(
        withURLString urlString: String,
        completion: @escaping (Result<Data, ViewModelError>) -> Void) {
        
        imageFetcherServices.fetchImageData(withURLString: urlString) { completion($0.mapError { ViewModelError($0) }) }
    }
}
