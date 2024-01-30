//
//  TopRatedModel.swift
//  MediaProject
//
//  Created by 최서경 on 1/30/24.
//

import Foundation
struct TopRatedModel: Decodable {
    let topRated: [TopRated]
    
    enum CodingKeys: String, CodingKey {
        case topRated = "results"
    }
}

struct TopRated: Codable{
    let id: Int
    let name: String
    let original_name: String
    let overview: String
    let poster_path: String
    let backdrop_path: String
}
