//
//  APIService.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

/// API Service layer which manages all the service calls made via Network manager
/// This class is responsible for all the request creation
/// You can also create custom Service class for handling LocalDB Service by implementing `ServiceProtocol`
final class APIService: ServiceProtocol {
    
    static let shared = APIService()

    private init() { }
    
    private let session = URLSession.shared

    func request<T: Codable>(request: NetworkRequestProtocol, modelType: T.Type, completion: @escaping (APIResult<T>?) -> Void) {
        
        /// Reachability check to avoid no network condition
        guard ReachabilityMonitor.shared.isConnected else {
            completion(.failure(.internetConnectionFailure))
            return
        }
        
        guard let urlRequest = getURLRequest(request: request, completion) else {
            completion(.failure(.urlParsingFailure))
            return
        }
        
        let task = session.dataTask(with: urlRequest) {data, response, error in
            
            if (response as? HTTPURLResponse)?.statusCode == 200{
                if let model = data?.decode(modelType) {
                    completion(.success(model))
                    return
                }
            }
            else {
                if let model = data?.decode(APIError.self){
                    completion(.failure(model))
                    return
                }
            }
            completion(.failure(.responseParsingFailure))
        }
        
        task.resume()
    }
    
    // This will be needed in case of dynamic attribute of response data
    func request(request: any NetworkRequestProtocol, completion: @escaping (APIResult<Data>?) -> Void) {
        
        /// Reachability check to avoid no network condition
        guard ReachabilityMonitor.shared.isConnected else {
            completion(.failure(.internetConnectionFailure))
            return
        }
        
        guard let urlRequest = getURLRequest(request: request, completion) else {
            completion(.failure(.urlParsingFailure))
            return
        }
        
        let task = session.dataTask(with: urlRequest) {data, response, error in
            
            DispatchQueue.main.async {
                
                if (response as? HTTPURLResponse)?.statusCode == 200{
                    if let data {
                        completion(.success(data))
                        return
                    }
                }
                else {
                    if let model = data?.decode(APIError.self){
                        completion(.failure(model))
                        return
                    }
                }
                completion(.failure(.responseParsingFailure))
            }
        }
        
        task.resume()
    }
    
    private func getURLRequest<T: Codable>(request: NetworkRequestProtocol,_ completion: @escaping (APIResult<T>?) -> Void) -> URLRequest?{
        
        guard let url = getURL(baseURL: request.baseURL, path: request.path, query: request.query) else {
            completion(.failure(.urlParsingFailure))
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.httpMethod
        urlRequest.allHTTPHeaderFields = request.headers
        
        do{
            urlRequest.httpBody = try request.postBody?.toData()
        }
        catch{
            completion(.failure(.postBodyParsingFailure))
            return nil
        }
        
        return urlRequest
    }
    
    
    private func getURL(baseURL: URL, path: String, query: JSONItem?) -> URL?{

        guard var urlComponent = URLComponents(string: path) else { return nil }
        
        let query = query as? [String: String] ?? [:]
        
        urlComponent.queryItems = query.map({ URLQueryItem(name: $0, value: $1) })
       
        return urlComponent.url(relativeTo: baseURL)
    }
    
}
