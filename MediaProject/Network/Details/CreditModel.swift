//
//  CreditManager.swift
//  MediaProject
//
//  Created by 최서경 on 1/31/24.
//

import Foundation
struct CreditModel: Decodable {
    // cast + crew
    let cast: [Credit]
    let crew: [Credit]

}

struct Credit: Decodable {
    let id: Int
    let name: String
    let original_name: String
    let profile_path: String?
}
