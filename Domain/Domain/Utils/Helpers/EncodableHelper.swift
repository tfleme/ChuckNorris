//
//  EncodableHelper.swift
//  Domain
//
//  Created by Tiago Leme on 05/08/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import Foundation

final class EncodableHelper {
    
    static func encode<T: Encodable>(_ encodable: T, encoder: JSONEncoder = .init()) -> Data? {
        do {
            return try encoder.encode(encodable)
        } catch {
            print(error)
            return nil
        }
    }
}

