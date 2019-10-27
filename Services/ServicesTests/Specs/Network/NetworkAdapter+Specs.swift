//
//  NetworkAdapter+Specs.swift
//  ServicesTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Quick
import Nimble

@testable import Services

struct URLSessionStub: UserSessionType {
    
    enum ResultType {
        case success
        case invalidResponse
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
    
    func dataTask(
        with urlRequest: URLRequest,
        result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        
        switch resultType {
        case .success:
            
            let urlResponse = HTTPURLResponse(
                url: URL(string: "https://mockedurl.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil)!
            
            result(.success((urlResponse, mockedData)))
        case .invalidResponse:
            
            let urlResponse = HTTPURLResponse(
                url: URL(string: "https://mockedurl.com")!,
                statusCode: 400,
                httpVersion: nil,
                headerFields: nil)!
            
            result(.success((urlResponse, mockedData)))
        case .failure:
            result(.failure(ServiceError(.generic)))
        }
        
        return URLSessionDataTask()
    }
}

final class NetworkAdapter_Specs: QuickSpec {
    
    override func spec() {
        describe("NetworkAdapter") {
            
            let endpoint = Endpoint(httpMethod: .get, urlString: "https://mockedurl.com")
            let networkRequest = NetworkRequest(endpoint: endpoint)
            
            var networkAdapter: NetworkAdapter!
            var urlSession: URLSessionStub!
            
            context("When call is called expecting success") {
                it("returns a data object") {
                    
                    urlSession = URLSessionStub(resultType: .success)
                    networkAdapter = NetworkAdapter(urlSession: urlSession)
                    
                    networkAdapter.call(networkRequest) { result in
                    
                        switch result {
                        case .success(let data):
                            expect(data) == urlSession.mockedData
                        case .failure:
                            expect(0).to(beNil())
                        }
                    }
                }
            }
            
            context("When call is called expecting invalid response") {
                it("returns an invalid response service error") {
                    
                    urlSession = URLSessionStub(resultType: .invalidResponse)
                    networkAdapter = NetworkAdapter(urlSession: urlSession)
                    
                    networkAdapter.call(networkRequest) { result in
                    
                        switch result {
                        case .success:
                            expect(0).to(beNil())
                        case .failure(let error):
                            expect(error) == ServiceError(.invalidResponse)
                        }
                    }
                }
            }
            
            context("When call is called expecting failure") {
                it("returns a generic service error") {
                    
                    urlSession = URLSessionStub(resultType: .failure)
                    networkAdapter = NetworkAdapter(urlSession: urlSession)
                    
                    networkAdapter.call(networkRequest) { result in
                    
                        switch result {
                        case .success:
                            expect(0).to(beNil())
                        case .failure(let error):
                            expect(error) == ServiceError(.generic)
                        }
                    }
                }
            }
        }
    }
}
