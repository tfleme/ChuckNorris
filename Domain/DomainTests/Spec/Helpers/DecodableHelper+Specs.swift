//
//  DecodableHelper+Specs.swift
//  DomainTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Quick
import Nimble

@testable import Domain

final class DecodableHelper_Specs: QuickSpec {

    override func spec() {
        describe("DecodableHelper") {

            beforeEach {

            }
            
            describe("decode") {
                context("When a valid codable data object is passed as an argument") {
                    it("returns an instance of the codable object") {
                        
                        let mockedJoke = Joke(
                            iconUrlString: "https://mockurl.com",
                            value: "This is a mock chuck norris joke with a text so you can have a big big laugh",
                            urlString: "https://mockurl.com")
                        
                        let data = """
                            {
                                "icon_url": "https://mockurl.com",
                                "value": "This is a mock chuck norris joke with a text so you can have a big big laugh",
                                "url": "https://mockurl.com"
                            }
                        """.data(using: .utf8)!
                        let joke: Joke = DecodableHelper.decode(data)!
                        
                        expect(joke) == mockedJoke
                    }
                }
                
                context("When an invalid codable data object is passed as an argument") {
                    it("returns an instance of the codable object") {
                        
                        let data = """
                            {
                                "icon_url": "https://mockurl.com",
                                "invalid_argumet": "This is a mock chuck norr"
                            }
                        """.data(using: .utf8)!
                        let joke: Joke? = DecodableHelper.decode(data)
                        
                        expect(joke).to(beNil())
                    }
                }
            }
        }
    }
}
