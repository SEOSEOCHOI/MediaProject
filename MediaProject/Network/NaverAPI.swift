//
//  NaverAPI.swift
//  MediaProject
//
//  Created by 최서경 on 2/14/24.
//

import Foundation
import Alamofire

enum NaverAPI {
    case image(query: String)
    
    
    private var baseURL: String {
        return "https://openapi.naver.com/v1/"
    }
    
    var endPoint: URL {
        switch self {
        case .image:
            return URL(string: baseURL + "search/image")!
        }
    }
    
    var header: HTTPHeaders {
        return ["X-Naver-Client-Id":APIKey.clientID,
                "X-Naver-Client-Secret":APIKey.clientSecret]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        switch self {
        case .image(let query):
            ["query":query]
        }
    }
    
}
