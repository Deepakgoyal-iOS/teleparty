//
//  DataExtension.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

extension Data {

    func decode<T: Decodable>(_ responseType: T.Type) -> T?{
        return try? JSONDecoder().decode(responseType, from: self)
    }
}
