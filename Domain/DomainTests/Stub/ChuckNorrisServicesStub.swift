//
//  ChuckNorrisServicesStub.swift
//  DomainTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

@testable import Services

struct ChuckNorrisServicesStub: ChuckNorrisServicesType {

    enum ResultType {
        case success
        case failure
        case badResponse
    }

    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    var categories: Data {
        return """
            [
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
        """.data(using: .utf8)!
    }
    
    var joke: Data {
        return """
            {
                "icon_url": "https://mockurl.com",
                "value": "This is a mock chuck norris joke with a big text so you can have a big big laugh"
            }
        """.data(using: .utf8)!
    }
    
    var error: ServiceError {
        return ServiceError(.generic)
    }

    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------

    private let resultType: ResultType

    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------

    init(resultType: ResultType) {
        self.resultType = resultType
    }

    //-----------------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------------
    
    func fetchCategories(completion: @escaping (Result<Data, ServiceError>) -> Void) {
        
        switch resultType {
        case .success:
            completion(.success(categories))
        case .failure:
            completion(.failure(error))
        case .badResponse:
            completion(.success(Data()))
        }
    }
    
    func fetchJoke(
        fromCategoryString categoryString: String,
        completion: @escaping (Result<Data, ServiceError>) -> Void) {
        
        switch resultType {
        case .success:
            completion(.success(joke))
        case .failure:
            completion(.failure(error))
        case .badResponse:
            completion(.success(Data()))
        }
    }
}
