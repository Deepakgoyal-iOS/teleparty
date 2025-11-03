//
//  PrimeVideoGETRequest.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

class PrimeVideoGETRequest: PrimeVideoNetworkRequest{

    init(path: String, query: JSONItem? = nil) {
        super.init(path: path, method: .get, query: query)
    }
}
