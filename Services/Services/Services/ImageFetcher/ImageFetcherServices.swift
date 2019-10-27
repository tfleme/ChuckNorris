//
//  ImageFetcherServices.swift
//  Services
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

public protocol ImageFetcherServicesType {
    func fetchImageData(withURLString urlString: String, completion: @escaping (Result<Data, ServiceError>) -> Void)
}

final class ImageFetcherServices: ImageFetcherServicesType {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let network: NetworkAdapterType
    private let cache: CacheType
    
    //-----------------------------------------------------------------------------
    // MARK: - Initalization
    //-----------------------------------------------------------------------------
    
    init(network: NetworkAdapterType, cache: CacheType) {
        
        self.network = network
        self.cache = cache
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------------
    
    public func fetchImageData(
        withURLString urlString: String,
        completion: @escaping (Result<Data, ServiceError>) -> Void) {
        
        if let imageData = imageDataFromCache(urlString: urlString) {
            completion(.success(imageData))
        } else {
            imageDataFromService(urlString: urlString, completion: completion)   
        }
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods
//-----------------------------------------------------------------------------

extension ImageFetcherServices {
    
    private func imageDataFromCache(urlString: String) -> Data? {
        return cache[urlString]
    }
    
    private func imageDataFromService(urlString: String, completion: @escaping (Result<Data, ServiceError>) -> Void) {
        
        let endpoint = Endpoint(httpMethod: .get, urlString: urlString)
        let networkRequest = NetworkRequest(endpoint: endpoint)
        
        network.call(networkRequest) { [weak self] result in
            
            switch result {
            case .success(let data):
            
                self?.cache[urlString] = data
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
