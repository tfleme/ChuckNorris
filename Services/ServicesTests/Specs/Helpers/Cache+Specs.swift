//
//  Cache+Specs.swift
//  ServicesTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Quick
import Nimble

@testable import Services

final class Cache_Specs: QuickSpec {

    override func spec() {
        describe("Cache") {
            
            let cache = Cache.shared
            
            context("When cache subscript is called expecting success") {
                it("returns nil") {
                    
                    let data = Data()
                    cache["success"] = data
                    let value: Data? = cache["success"]
                    expect(value) == data
                }
            }
            
            context("When cache subscript is called expecting failure") {
                it("returns nil") {
                    
                    let value: Data? = cache["failure"]
                    expect(value).to(beNil())
                }
            }
        }
    }
}
