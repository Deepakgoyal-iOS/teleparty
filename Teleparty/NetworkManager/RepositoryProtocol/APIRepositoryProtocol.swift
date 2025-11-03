//
//  APIRepositoryProtocol.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

protocol APIRepositoryProtocol {
    var service: ServiceProtocol { get }
    func performAPI<T: Codable>(responseType: T.Type, _ completionHandler: @escaping ( _ response: APIResult<T>?) -> Void)
    func performAPI(_ completionHandler: @escaping ( _ response: APIResult<JSONItem>?) -> Void)
}
extension APIRepositoryProtocol{
    
    // You can change service to local DB if our app supports any offline feature.
    var service: ServiceProtocol {
        return APIService.shared
    }
    
    func performAPI(_ completionHandler: @escaping ( _ response: APIResult<JSONItem>?) -> Void){
        // Implement if needed
    }
}
