//
//  Joke.swift
//  Domain
//
//  Created by Tiago Leme on 23/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

public struct Joke: Codable {
    
    public let iconUrlString: String
    public let value: String
    
    enum CodingKeys: String, CodingKey {
        case iconUrlString = "icon_url"
        case value = "value"
    }
}

