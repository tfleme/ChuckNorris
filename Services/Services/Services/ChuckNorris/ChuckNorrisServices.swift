//
//  ChuckNorrisServices.swift
//  Services
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

public protocol ChuckNorrisServicesType {
    func fetchCategories(completion: @escaping (Result<Data, ServiceError>) -> Void)
    func fetchJoke(
        fromCategoryString categoryString: String,
        completion: @escaping (Result<Data, ServiceError>) -> Void)
}

final class ChuckNorrisServices: ChuckNorrisServicesType {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let network: NetworkAdapterType
    
    private var api = ChuckNorrisAPI()
    
    //-----------------------------------------------------------------------------
    // MARK: - Initalization
    //-----------------------------------------------------------------------------
    
    init(network: NetworkAdapterType) {
        self.network = network
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------------
    
    func fetchCategories(completion: @escaping (Result<Data, ServiceError>) -> Void) {
        
        let networkRequest = NetworkRequest(endpoint: api.fetchCategoriesEndpoint)
        network.call(networkRequest, completion: completion)
    }
    
    func fetchJoke(
        fromCategoryString categoryString: String,
        completion: @escaping (Result<Data, ServiceError>) -> Void) {
        
        let networkRequest = NetworkRequest(endpoint: api.fetchJokeFromCategoryEndpoint(categoryString))
        network.call(networkRequest, completion: completion)
    }
}
