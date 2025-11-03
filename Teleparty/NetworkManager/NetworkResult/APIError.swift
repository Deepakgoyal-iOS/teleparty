//
//  APIError.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

public struct APIError: Decodable, Error {
    var statusCode: Int?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case message
    }
    
    init(withError error: Error) {
        self.statusCode = (error as NSError).code
        self.message = error.localizedDescription
    }
    
    init(statusCode: Int, message: String){
        self.statusCode = statusCode
        self.message = message
    }
}
extension APIError{
    
    static let urlParsingFailure = APIError(statusCode: 400, message: "TeleParty Network : URL parsing failed, can't hit request")
    static let postBodyParsingFailure = APIError(statusCode: 400, message: "TeleParty Network : Post Body parsing failed, can't hit request")
    static let queryParsingFailure = APIError(statusCode: 400, message: "TeleParty Network : Query parsing failed, can't hit request")
    static let responseParsingFailure = APIError(statusCode: 404, message: "TeleParty Network : Response parsing failed")
    static let internetConnectionFailure = APIError(statusCode: -1, message: "No Internet Connection")
}
