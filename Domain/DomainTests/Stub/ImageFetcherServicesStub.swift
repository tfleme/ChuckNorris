//
//  ImageFetcherServicesStub.swift
//  DomainTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit

@testable import Services

struct ImageFetcherServicesStub: ImageFetcherServicesType {
    
    enum ResultType {
        case success
        case failure
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------

    var mockedImageData: Data {
        return """
            0xAF1234
        """.data(using: .utf8)!
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
    
    func fetchImageData(withURLString urlString: String, completion: @escaping (Result<Data, ServiceError>) -> Void) {
        
        switch resultType {
        case .success:
            completion(.success(mockedImageData))
        case .failure:
            completion(.failure(ServiceError(.generic)))
        }
    }
}
