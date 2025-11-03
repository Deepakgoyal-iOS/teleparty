//
//  URLRequestExtension.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

extension URLRequest {
    
    // For testing
    public var curl: String {
        
        guard let url = url else { return "error" }
        
        var baseCommand = "curl "
        
        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }
        
        /// Base Command storage
        var command = [baseCommand]
        
        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }
        
        /// Header injection
        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H \"\(key): \(value)\"")
            }
        }
        
        /// compressed URL injection
        command.append("--compressed \"\(url.absoluteString)\"")
        
        /// post body injection
        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("--data-binary '\(body)'")
        }
        
        return command.joined(separator: " ")
    }
}
