//
//  EncodableExtension.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

extension Encodable{
    
    func asDictionary() -> JSONItem?{
        
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? JSONItem }
    }
}
