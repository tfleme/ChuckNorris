//
//  Endpoint.swift
//  app_costumer
//
//  Created by Tiago Leme on 26/08/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

struct Endpoint {
    
    enum HttpMethod: String {
        case post = "POST"
        case get = "GET"
        case put = "PUT"
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    let httpMethod: HttpMethod
    let url: URL
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(httpMethod: HttpMethod, urlString: String) {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL string: \(urlString)")
        }
        
        self.url = url
        self.httpMethod = httpMethod
    }
}
