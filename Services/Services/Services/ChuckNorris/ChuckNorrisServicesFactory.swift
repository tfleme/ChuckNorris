//
//  ChuckNorrisServicesFactory.swift
//  Services
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

public protocol ChuckNorrisServicesFactory {
    var chuckNorrisServices: ChuckNorrisServicesType { get }
}

extension DependencyContainer: ChuckNorrisServicesFactory {
    
    public var chuckNorrisServices: ChuckNorrisServicesType {
        return ChuckNorrisServices(network: NetworkAdapter())
    }
}
