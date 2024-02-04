//
//  SearchModel.swift
//  MediaProject
//
//  Created by 최서경 on 1/31/24.
//

import Foundation
struct SearchModel: Decodable {
    let results: [Search]
}
struct Search: Decodable {
    let original_name: String
    let name: String
    let id: Int
    let poster_path: String?
}
