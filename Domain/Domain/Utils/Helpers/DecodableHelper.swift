//
//  DecodableHelper.swift
//  Domain
//
//  Created by Tiago Leme on 14/08/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

final class DecodableHelper {
    
    static func decode<T: Decodable>(_ data: Data, decoder: JSONDecoder = .init()) -> T? {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
