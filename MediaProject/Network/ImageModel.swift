//
//  ImageModel.swift
//  MediaProject
//
//  Created by 최서경 on 2/14/24.
//

import Foundation

struct ImageModel: Decodable {
    let imageModel: [ImageItem]
    
    enum CodingKeys: String, CodingKey {
        case imageModel = "items"
    }
}

struct ImageItem: Decodable {
    let link: String
}
