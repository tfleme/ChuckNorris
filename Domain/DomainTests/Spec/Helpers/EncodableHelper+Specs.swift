//
//  EncodableHelper+Specs.swift
//  DomainTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Quick
import Nimble

@testable import Domain

final class EncodableHelper_Specs: QuickSpec {

    override func spec() {
        
        describe("EncodableHelper") {
            
            describe("encode") {
                context("When a valid codable object is passed as an argument") {
                    it("returns an instance of the codable data object") {
                        
                        let mockedJoke = Joke(
                            iconUrlString: "https://mockurl.com",
                            value: "This is a mock chuck norris joke with a text so you can have a big big laugh",
                            urlString: "https://mockurl.com")
   
                        let data: Data = EncodableHelper.encode(mockedJoke)!
                        let decodedJoke: Joke = DecodableHelper.decode(data)!
                        
                        expect(mockedJoke) == decodedJoke
                    }
                }
                
                context("When an invalid codable object is passed as an argument") {
                    it("returns an instance of the codable object") {
                        
                        struct InvalidEncodable: Codable {
                            let value: Double
                        }
                        
                        let invalidEncodable = InvalidEncodable(value: Double.infinity)
                        let data: Data? = EncodableHelper.encode(invalidEncodable)

                        expect(data).to(beNil())
                    }
                }
            }
        }
    }
}
