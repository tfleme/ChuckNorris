//
//  ChuckNorrisAPI.swift
//  Services
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

struct ChuckNorrisAPI {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let baseAPI = "https://api.chucknorris.io/jokes"
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    lazy var fetchCategoriesEndpoint: Endpoint = {
        return Endpoint(httpMethod: .get, urlString: endpointURLString("/categories"))
    }()
    
    //-----------------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------------
    
    func fetchJokeFromCategoryEndpoint(_ categoryString: String) -> Endpoint {
        return Endpoint(httpMethod: .get, urlString: endpointURLString("/random?category=\(categoryString)"))
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods
//-----------------------------------------------------------------------------

extension ChuckNorrisAPI {
    
    private func endpointURLString(_ string: String) -> String {
        return baseAPI + string
    }
}
