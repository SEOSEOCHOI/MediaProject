//
//  NaverImageAPIManager.swift
//  MediaProject
//
//  Created by 최서경 on 2/14/24.
//

import Foundation
import Foundation
import Alamofire

struct NaverImageAPIManager {
    static let shared = NaverImageAPIManager()
    func callRequest(api: NaverAPI, completionHandelr: @escaping (ImageModel) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameters,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: ImageModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandelr(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

