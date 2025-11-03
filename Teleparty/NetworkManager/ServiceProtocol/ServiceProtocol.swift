//
//  ServiceProtocol.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

protocol ServiceProtocol {
    
    /// Network Request with predefined model type to parse the response
    /// - Parameters:
    ///   - request: Service request to perform
    ///   - modelType: Model to decode the response
    ///   - completion: completion block to ping the request result
    func request<T: Codable>(request: NetworkRequestProtocol, modelType: T.Type, completion: @escaping (APIResult<T>?) -> Void)
    
    // Get data without any parsing
    func request(request: NetworkRequestProtocol, completion: @escaping (APIResult<Data>?) -> Void)
    
}
