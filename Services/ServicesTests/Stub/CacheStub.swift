//
//  CacheStub.swift
//  ServicesTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

@testable import Services

final class CacheStub: CacheType {
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private var cache: [String: Any] = [:]
    
    //-----------------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------------
    
    subscript<T>(key: String) -> T? {
        get {
            return cache[key] as? T
        }
        set {
            cache[key] = newValue
        }
    }
}
