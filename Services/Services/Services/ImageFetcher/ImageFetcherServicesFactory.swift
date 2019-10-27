//
//  ImageFetcherServicesFactory.swift
//  Services
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

public protocol ImageFetcherServicesFactory {
    var imageFetcherServices: ImageFetcherServicesType { get }
}

extension DependencyContainer: ImageFetcherServicesFactory {
    
    public var imageFetcherServices: ImageFetcherServicesType {
        return ImageFetcherServices(network: NetworkAdapter(), cache: Cache.shared)
    }
}
