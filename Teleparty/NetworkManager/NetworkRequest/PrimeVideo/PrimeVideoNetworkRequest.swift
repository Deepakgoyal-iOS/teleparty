//
//  PrimeVideoNetworkRequest.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

class PrimeVideoNetworkRequest: NetworkRequestProtocol{

    var path: String
    
    var postBody: JSONItem?
    
    var query: JSONItem?

    var method: RequestMethod
    
    var baseURL: URL{
        return URL(string: "https://www.primevideo.com")!
    }
    
    var headers: [String : String]{
        return ["x-requested-with": "WebSPA", "accept": "application/json"]
    }
    
    init(path: String, method: RequestMethod, postBody: JSONItem? = nil, query: JSONItem? = nil) {
        self.path = path
        self.postBody = postBody
        self.query = query
        self.method = method
    }
    
}

