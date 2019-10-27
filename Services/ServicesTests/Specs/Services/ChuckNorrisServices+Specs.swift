//
//  ChuckNorrisServices+Specs.swift
//  ServicesTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Quick
import Nimble

@testable import Services

final class ChuckNorrisServices_Specs: QuickSpec {

    override func spec() {
        describe("ChuckNorrisServices") {
            
            var services: ChuckNorrisServices!
            var networkAdapter: NetworkAdapterStub!
            
            context("When fetchCategories is called expecting success") {
                it("returns an data object") {
                    
                    networkAdapter = NetworkAdapterStub(resultType: .success)
                    services = ChuckNorrisServices(network: networkAdapter)
                    
                    services.fetchCategories { result in
                        
                        switch result {
                        case .success(let data):
                            expect(data) == networkAdapter.mockedData
                        case .failure:
                            expect(0).to(beNil())
                        }
                    }
                }
            } // fetchCategories
            
            context("When fetchJoke is called expecting success") {
                it("returns an data object") {
                    
                    networkAdapter = NetworkAdapterStub(resultType: .success)
                    services = ChuckNorrisServices(network: networkAdapter)
                    
                    services.fetchJoke(fromCategoryString: "") { result in
                        
                        switch result {
                        case .success(let data):
                            expect(data) == networkAdapter.mockedData
                        case .failure:
                            expect(0).to(beNil())
                        }
                    }
                }
            } // fetchJoke
            
            
            context("When fetchCategories is called expecting failure") {
                it("returns a list of categories") {
     
                    networkAdapter = NetworkAdapterStub(resultType: .failure)
                    services = ChuckNorrisServices(network: networkAdapter)
                    
                    services.fetchCategories { result in
                        
                        switch result {
                        case .success:
                            expect(0).to(beNil())
                        case .failure(let error):
                            expect(error) == networkAdapter.mockedError
                        }
                    }
                }
            } // fetchCategories
            
            context("When fetchJoke is called expecting failure") {
                it("returns a list of categories") {
                    
                    networkAdapter = NetworkAdapterStub(resultType: .failure)
                    services = ChuckNorrisServices(network: networkAdapter)
                    
                    services.fetchJoke(fromCategoryString: "") { result in
                        
                        switch result {
                        case .success:
                            expect(0).to(beNil())
                        case .failure(let error):
                            expect(error) == networkAdapter.mockedError
                        }
                    }
                }
            } // fetchJoke
        }
    }
}

//-----------------------------------------------------------------------------
// MARK: - ServiceError Equatable Extension
//-----------------------------------------------------------------------------

extension ServiceError: Equatable {

    public static func == (lhs: ServiceError, rhs: ServiceError) -> Bool {
        return lhs.title.elementsEqual(rhs.title) && lhs.message.elementsEqual(rhs.message)
    }
}
