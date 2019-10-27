//
//  ServiceError.swift
//  Application
//
//  Created by Tiago Leme on 09/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

public struct ServiceError: Error {
    
    public enum ErrorType {
        case generic
        case invalidResponse
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------------
    
    public let title: String
    public let message: String
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    public init(title: String = "Error", message: String) {
        
        self.title = title
        self.message = message
    }
    
    public init(_ type: ErrorType) {
        
        switch type {
        case .generic:
            self.init(message: "We're having trouble completing your request")
        case .invalidResponse:
            self.init(message: "We're having trouble completing your request")
        }
    } 
}
