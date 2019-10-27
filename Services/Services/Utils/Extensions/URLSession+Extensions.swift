//
//  URLSession+Extensions.swift
//  Services
//
//  Created by Tiago Leme on 25/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

extension URLSession {
    
    func dataTask(
        with urlRequest: URLRequest,
        result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {

        return dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
