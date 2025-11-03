//
//  APIResult.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

typealias JSONItem = [String: Any]

public enum APIResult<T> {
    case success(T)
    case failure(APIError)
}
