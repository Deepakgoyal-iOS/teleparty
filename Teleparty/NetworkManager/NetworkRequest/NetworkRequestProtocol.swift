//
//  NetworkRequestProtocol.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

enum RequestMethod{
    case get
    case put
    case post
    case delete
    
    var httpMethod: String{
        
        switch self {
        case .get:
            return "GET"
        case .put:
            return "PUT"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}


protocol NetworkRequestProtocol {
    
    var path: String { get set }

    var postBody: JSONItem? { get set }
    
    var query: JSONItem? { get set }
    
    var method: RequestMethod { get set }
    
    var headers: [String : String] { get }
    
    var baseURL: URL { get }
    
}
