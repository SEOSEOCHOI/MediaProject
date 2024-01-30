//
//  PopularModel.swift
//  MediaProject
//
//  Created by 최서경 on 1/30/24.
//

import Foundation
struct PopularModel: Decodable {
    let popular: [Popular]
 
    enum CodingKeys: String, CodingKey {
        case popular = "results"
    }
}

struct Popular: Decodable{
    let id: Int
    let name: String
    let original_name: String
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
}
