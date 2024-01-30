//
//  TrendingModel.swift
//  MediaProject
//
//  Created by 최서경 on 1/30/24.
//

import Foundation

struct TrendingModel: Decodable {
    let trending: [Trending]
    
    enum CodingKeys: String, CodingKey {
        case trending = "results"
    }
}

struct Trending: Decodable{
    let id: Int
    let name: String
    let original_name: String
    let overview: String
    let poster_path: String
    let backdrop_path: String
}
