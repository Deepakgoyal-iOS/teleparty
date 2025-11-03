//
//  PrimeVideoDetailsModel.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation

struct PrimeVideoDetailsModel: Codable{
    
    struct Images: Codable{
        var packshot: String?
        var covershot: String?
        
        enum CodingKeys: CodingKey {
            case packshot
            case covershot
        }
    }
    
    var title: String?
    var synopsis: String?
    var releaseDate: String?
    var runtime: String?
    var entityType: String?
    var images: Images?
    
    enum CodingKeys: CodingKey {
        case title
        case synopsis
        case releaseDate
        case runtime
        case entityType
        case images
    }
}
