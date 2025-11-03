//
//  DictionaryExtension.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import UIKit

extension Dictionary {

    func toData() throws -> Data {
        return try JSONSerialization.data(withJSONObject: self)
    }
    
    func toModel<T: Codable>(modelType: T.Type, state: ((_ inProgress: Bool) -> Void)? = nil,  _ completion: @escaping (_ model: T?) -> Void){
        
        state?(true)
        DispatchQueue(label: "bg-thread", qos: .userInitiated).async{
            
            let data = try? toData()
            let model = data?.decode(T.self)
            DispatchQueue.main.async {
                completion(model)
                state?(false)
            }
        }
    }
}
