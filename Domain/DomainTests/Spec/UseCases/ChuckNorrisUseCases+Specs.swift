//
//  ChuckNorrisUseCases+Specs.swift
//  DomainTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Quick
import Nimble

@testable import Domain
@testable import Services

final class ChuckNorrisUseCases_Specs: QuickSpec {

    override func spec() {
        describe("ChuckNorrisUseCases") {
            describe("init") {
                
                var useCases: ChuckNorrisUseCases!
                var services: ChuckNorrisServicesStub!
                var imageFetcherServices: ImageFetcherServicesStub!
                
                beforeEach {
                    
                }
             
                context("When categories is called expecting success") {
                    it("returns a list of categories") {
                        services = ChuckNorrisServicesStub(resultType: .success)
                        imageFetcherServices = ImageFetcherServicesStub(resultType: .success)
                        useCases = ChuckNorrisUseCases(services: services, imageFetcherServices: imageFetcherServices)
                        
                        useCases.categories { result in
                            
                            switch result {
                            case .success(let categories):
                                guard
                                    let mockCategories: [JokeCategory] = DecodableHelper.decode(services.categories)
                                else { return }
                                
                                expect(categories) == mockCategories
                            case .failure:
                                expect(0).to(beNil())
                            }
                        }
                    }
                } // categories
                
                context("When joke is called expecting success") {
                    it("returns a joke object") {
                        services = ChuckNorrisServicesStub(resultType: .success)
                        imageFetcherServices = ImageFetcherServicesStub(resultType: .success)
                        useCases = ChuckNorrisUseCases(services: services, imageFetcherServices: imageFetcherServices)
                        
                        useCases.joke(from: "food") { result in
                            
                            switch result {
                            case .success(let joke):
                                guard let mockedJoke: Joke = DecodableHelper.decode(services.joke) else { return }
                                
                                expect(joke) == mockedJoke
                            case .failure:
                                expect(0).to(beNil())
                            }
                        }
                    }
                } // joke
                
                context("When imageData is called expecting success") {
                    it("returns a image data object") {
                        services = ChuckNorrisServicesStub(resultType: .success)
                        imageFetcherServices = ImageFetcherServicesStub(resultType: .success)
                        useCases = ChuckNorrisUseCases(services: services, imageFetcherServices: imageFetcherServices)
                        
                        useCases.imageData(withURLString: "") { result in
                            
                            switch result {
                            case .success(let imageData):
                                expect(imageData) == imageFetcherServices.mockedImageData
                            case .failure:
                                expect(0).to(beNil())
                            }
                        }
                    }
                } // imageData
                
                context("When categories is called expecting failure") {
                    it("returns a list of categories") {
                        services = ChuckNorrisServicesStub(resultType: .failure)
                        imageFetcherServices = ImageFetcherServicesStub(resultType: .failure)
                        useCases = ChuckNorrisUseCases(services: services, imageFetcherServices: imageFetcherServices)
                        
                        useCases.categories { result in
                            
                            switch result {
                            case .success:
                                expect(0).to(beNil())
                            case .failure(let error):
                                expect(error) == ViewModelError(services.error)
                            }
                        }
                    }
                } // categories
                
                context("When joke is called expecting failure") {
                    it("returns a joke object") {
                        services = ChuckNorrisServicesStub(resultType: .failure)
                        imageFetcherServices = ImageFetcherServicesStub(resultType: .failure)
                        useCases = ChuckNorrisUseCases(services: services, imageFetcherServices: imageFetcherServices)
                        
                        useCases.joke(from: "food") { result in
                            
                            switch result {
                            case .success:
                                expect(0).to(beNil())
                            case .failure(let error):
                                expect(error) == ViewModelError(services.error)
                            }
                        }
                    }
                } // joke
                
                context("When imageData is called expecting failure") {
                    it("returns a image data object") {
                        services = ChuckNorrisServicesStub(resultType: .failure)
                        imageFetcherServices = ImageFetcherServicesStub(resultType: .failure)
                        useCases = ChuckNorrisUseCases(services: services, imageFetcherServices: imageFetcherServices)
                        
                        useCases.imageData(withURLString: "") { result in
                            
                            switch result {
                            case .success:
                                expect(0).to(beNil())
                            case .failure(let error):
                                expect(error) == ViewModelError(services.error)
                            }
                        }
                    }
                } // imageData
                
                context("When categories is called expecting bad response") {
                    it("returns a list of categories") {
                        services = ChuckNorrisServicesStub(resultType: .badResponse)
                        imageFetcherServices = ImageFetcherServicesStub(resultType: .failure)
                        useCases = ChuckNorrisUseCases(services: services, imageFetcherServices: imageFetcherServices)
                        
                        useCases.categories { result in
                            
                            switch result {
                            case .success:
                                expect(0).to(beNil())
                            case .failure(let error):
                                expect(error) == ViewModelError(services.error)
                            }
                        }
                    }
                } // categories
                
                context("When joke is called expecting bad response") {
                    it("returns a joke object") {
                        services = ChuckNorrisServicesStub(resultType: .badResponse)
                        imageFetcherServices = ImageFetcherServicesStub(resultType: .failure)
                        useCases = ChuckNorrisUseCases(services: services, imageFetcherServices: imageFetcherServices)
                        
                        useCases.joke(from: "food") { result in
                            
                            switch result {
                            case .success:
                                expect(0).to(beNil())
                            case .failure(let error):
                                expect(error) == ViewModelError(services.error)
                            }
                        }
                    }
                } // joke
            }
        }
    }
}

//-----------------------------------------------------------------------------
// MARK: - Joke Equatable Extension
//-----------------------------------------------------------------------------

extension Joke: Equatable {
    
    public static func == (lhs: Joke, rhs: Joke) -> Bool {
        return lhs.iconUrlString.elementsEqual(rhs.iconUrlString) && lhs.value.elementsEqual(rhs.value)
    }
}

//-----------------------------------------------------------------------------
// MARK: - ViewModelError Equatable Extension
//-----------------------------------------------------------------------------

extension ViewModelError: Equatable {
    
    public static func == (lhs: ViewModelError, rhs: ViewModelError) -> Bool {
        return lhs.title.elementsEqual(rhs.title) && lhs.message.elementsEqual(rhs.message)
    }
}
