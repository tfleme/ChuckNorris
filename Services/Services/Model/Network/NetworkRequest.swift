//
//  NetworkRequest.swift
//  app_costumer
//
//  Created by Tiago Leme on 23/08/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

struct NetworkRequest {
    
    let endpoint: Endpoint
    let body: [String: Any]?
    let headers: [String: String]?
    
    init(endpoint: Endpoint,
         body: [String: Any]? = nil,
         headers: [String: String]? = nil) {
        
        self.endpoint = endpoint
        self.body = body
        self.headers = headers
    }
}

