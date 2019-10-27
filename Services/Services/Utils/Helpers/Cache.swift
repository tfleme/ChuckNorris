//
//  Cache.swift
//  Services
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

protocol CacheType: class {
    subscript<T>(key: String) -> T? { get set }
}

final class Cache: CacheType {
        
    //-----------------------------------------------------------------------------
    // MARK: - Static properties
    //-----------------------------------------------------------------------------
    
    static let shared = Cache()
    
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let cache = NSCache<NSString, AnyObject>()
    
    //-----------------------------------------------------------------------------
    // MARK: - Private initializer
    //-----------------------------------------------------------------------------
    
    private init () {
        
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------------
    
    subscript<T>(key: String) -> T? {
        get {
            return cache.object(forKey: key as NSString) as? T
        }
        set {
            cache.setObject(newValue as AnyObject, forKey: key as NSString)
        }
    }
}
