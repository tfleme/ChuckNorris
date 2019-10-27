//
//  ViewModelError.swift
//  Domain
//
//  Created by Tiago Leme on 10/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation
import Services

public struct ViewModelError: Error {
    
    public enum ErrorType {
        case generic
        case parsing
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
        case .parsing:
            self.init(message: "We're having trouble completing your request")
        }
    }
    
    public init(_ error: ServiceError?) {
        guard let error = error else {
            self.init(.generic)
            return
        }
        
        self.init(message: error.message)
    }
}
