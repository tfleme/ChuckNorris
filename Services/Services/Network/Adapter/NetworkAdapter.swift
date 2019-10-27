//
//  NetworkAdapter.swift
//  PurpleConciergeServices
//
//  Created by Tiago Leme on 27/05/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

protocol UserSessionType {
    func dataTask(
        with urlRequest: URLRequest,
        result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask
}

extension URLSession: UserSessionType {
    
}

protocol NetworkAdapterType {
    func call(_ request: NetworkRequest, completion: @escaping (Result<Data, ServiceError>) -> Void)
}

final class NetworkAdapter: NetworkAdapterType {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private methods
    //-----------------------------------------------------------------------------

    private let urlSession: UserSessionType
    private let timeoutInterval: TimeInterval
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(urlSession: UserSessionType = URLSession.shared, timeoutInterval: TimeInterval = 30.0) {
        
        self.urlSession = urlSession
        self.timeoutInterval = timeoutInterval
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------------
    
    func call(_ request: NetworkRequest, completion: @escaping (Result<Data, ServiceError>) -> Void) {
    
        urlSession.dataTask(with: urlRequest(request)) { [weak self] result in
            
            switch result {
            case .success(let response, let data):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    self?.debugResponse(data)
                    completion(.failure(ServiceError(.invalidResponse)))
                    return
                }
  
                self?.debugResponse(data)
                
                completion(.success(data))
            case .failure(let error):
                print(error)
                completion(.failure(ServiceError(.generic)))
            }
        }.resume()
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Helpers
//-----------------------------------------------------------------------------

extension NetworkAdapter {
    
    private func urlRequest(_ request: NetworkRequest) -> URLRequest {
        
        var urlRequest = URLRequest(
            url: request.endpoint.url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: timeoutInterval)
        
        urlRequest.httpMethod = request.endpoint.httpMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = data(for: request.body)
        
        if let headers = request.headers {
            headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        }
        
        debugRequest(urlRequest)
        
        return urlRequest
    }
    
    private func data(for dictionary: [String : Any]?) -> Data? {
        guard
            let dictionary = dictionary,
            let data = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        else { return nil }
        
        return data
    }
}

//-----------------------------------------------------------------------------
// MARK: - Private methods - Debug
//-----------------------------------------------------------------------------

extension NetworkAdapter {
    
    private func debugRequest(_ request: URLRequest) {
        
        #if DEBUG
            print("\nEndpoint:{\n\t\(request.debugDescription)\n}")
            print("Headers:{\n\t\(request.allHTTPHeaderFields?.debugDescription ?? "")\n}")
            if let data = request.httpBody {
                print("Body:{\n\t\(String(data: data, encoding: .utf8) ?? "")\n}")
            }
            print("")
        #endif
    }
    
    private func debugResponse(_ data: Data) {
        
        #if DEBUG
            print("Result: \(String(data: data, encoding: .utf8) ?? "")\n")
        #endif
    }
}
