//
//  PrimeVideoDetailsAPIRepository.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

class PrimeVideoDetailsAPIRepository: APIRepositoryProtocol{
    
    struct QueryData: Codable{
        var clientVersion: String
        
        enum CodingKeys: String, CodingKey {
            case clientVersion = "dvWebSPAClientVersion"
        }
    }
    
    var id: String
    var ref: String
    var query: QueryData
    
    init(id: String, ref: String, query: QueryData) {
        self.id = id
        self.ref = ref
        self.query = query
    }
    
    // Can you if you have data model written for direct object decoding.
    func performAPI<T>(responseType: T.Type, _ completionHandler: @escaping (APIResult<T>?) -> Void) where T : Decodable, T : Encodable {
        
        guard let queryData = query.asDictionary() else {
            completionHandler(.failure(.queryParsingFailure))
            return
        }
        
        var path = APIRoutes.PrimeVideo.details
        path = path.replacingOccurrences(of: "<id>", with: id).replacingOccurrences(of: "<REF>", with: ref)
    
        service.request(request: PrimeVideoGETRequest(path: path, query: queryData), modelType: responseType, completion: completionHandler)
    }
    
    // Needed this extra overhead because of dynamic pageTitleID
    func performAPI(_ completionHandler: @escaping ( _ response: APIResult<JSONItem>?) -> Void){
        
        guard let queryData = query.asDictionary() else {
            completionHandler(.failure(.queryParsingFailure))
            return
        }
        
        var path = APIRoutes.PrimeVideo.details
        path = path.replacingOccurrences(of: "<id>", with: id).replacingOccurrences(of: "<REF>", with: ref)
    
        service.request(request: PrimeVideoGETRequest(path: path, query: queryData)){ response in
            
            switch response{
            case .success(let data):
                
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? JSONItem else {
                        completionHandler(.failure(.responseParsingFailure))
                        return
                    }
                    completionHandler(.success(json))
                }
                catch{
                    completionHandler(.failure(.responseParsingFailure))
                }
                
                break
            case .failure(let error):
                completionHandler(.failure(error))
                break
            default:
                completionHandler(nil)
            }
        }
    }
}
