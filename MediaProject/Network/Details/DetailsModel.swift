//
//  DetailsManager.swift
//  MediaProject
//
//  Created by 최서경 on 1/31/24.
//

import Foundation

struct DetailsModel: Codable {
    let backdrop_path: String
    let created_by: [Producer]
    let id: Int
    let name: String
    let original_name: String
    let overview: String?
    let poster_path: String?
}

struct Producer: Codable {
    let name: String
    let profile_path: String?
}
