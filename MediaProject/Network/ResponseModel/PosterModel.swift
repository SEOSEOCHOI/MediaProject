//
//  PosterModel.swift
//  MediaProject
//
//  Created by 최서경 on 1/30/24.
//

import Foundation
struct PosterModel: Decodable {
    let posters: [Poster]
}

struct Poster: Decodable {
    let file_path: String
}
