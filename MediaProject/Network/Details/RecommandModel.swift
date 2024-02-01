//
//  RecommandManager.swift
//  MediaProject
//
//  Created by 최서경 on 1/31/24.
//

import Foundation

struct RecommandModel: Decodable {
    let results: [Recommand]
}

struct Recommand: Decodable {
    let id: Int
    let name: String
    let original_name: String
    let poster_path: String?
}
