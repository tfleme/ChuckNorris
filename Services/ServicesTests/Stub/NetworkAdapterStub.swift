//
//  NetworkAdapterStub.swift
//  ServicesTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

@testable import Services

struct NetworkAdapterStub: NetworkAdapterType {
    
    enum ResultType {
        case success
        case failure
    }

    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    var mockedData: Data {
         return """
             0xAF1234
         """.data(using: .utf8)!
     }

    var mockedError: ServiceError {
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
    
    
    func call(_ request: NetworkRequest, completion: @escaping (Result<Data, ServiceError>) -> Void) {
        
        switch resultType {
        case .success:
            completion(.success(mockedData))
        case .failure:
            completion(.failure(mockedError))
        }
    }
}
