//
//  TopRatedModel.swift
//  MediaProject
//
//  Created by 최서경 on 1/30/24.
//

import Foundation
// Popular, Trending, TopRated, Recommand
struct TVShowModel: Decodable {
    let tvShow: [TVShow]
    
    enum CodingKeys: String, CodingKey {
        case tvShow = "results"
    }
}

struct TVShow: Codable{
    let id: Int
    let name: String
    let original_name: String
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
}
