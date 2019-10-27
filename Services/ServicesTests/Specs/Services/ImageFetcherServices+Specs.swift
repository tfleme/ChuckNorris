//
//  ImageFetcherServices+Specs.swift
//  ServicesTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Quick
import Nimble

@testable import Services

final class ImageFetcherServices_Specs: QuickSpec {

    override func spec() {
        describe("ImageFetcherServices") {
            
            var services: ImageFetcherServices!
            var networkAdapter: NetworkAdapterStub!
            var cache: CacheStub!
            
            context("When fetchImageData is called expecting success using cache") {
                it("returns an data object") {
                    
                    networkAdapter = NetworkAdapterStub(resultType: .success)
                    cache = CacheStub()
                    cache["https://mockedurl.com"] = networkAdapter.mockedData
                    services = ImageFetcherServices(network: networkAdapter, cache: cache)
                    
                    services.fetchImageData(withURLString: "https://mockedurl.com") { result in
                        
                        switch result {
                        case .success(let data):
                            expect(data) == networkAdapter.mockedData
                        case .failure:
                            expect(0).to(beNil())
                        }
                    }
                }
            } // fetchImageData
            
            context("When fetchImageData is called expecting success using services") {
                it("returns an data object") {
                    
                    networkAdapter = NetworkAdapterStub(resultType: .success)
                    cache = CacheStub()
                    services = ImageFetcherServices(network: networkAdapter, cache: cache)
                    
                    services.fetchImageData(withURLString: "https://mockedurl.com") { result in
                        
                        switch result {
                        case .success(let data):
                            expect(data) == networkAdapter.mockedData
                        case .failure:
                            expect(0).to(beNil())
                        }
                    }
                }
            } // fetchImageData
            
            context("When fetchImageData is called expecting failure") {
                it("returns a list of categories") {
                    
                    networkAdapter = NetworkAdapterStub(resultType: .failure)
                    cache = CacheStub()
                    services = ImageFetcherServices(network: networkAdapter, cache: cache)
                    
                    services.fetchImageData(withURLString: "https://mockedurl.com") { result in
                        
                        switch result {
                        case .success:
                            expect(0).to(beNil())
                        case .failure(let error):
                            expect(error) == networkAdapter.mockedError
                        }
                    }
                }
            } // fetchImageData
        }
    }
}
