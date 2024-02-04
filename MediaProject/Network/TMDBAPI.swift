//
//  TMDBAPI.swift
//  MediaProject
//
//  Created by 최서경 on 2/1/24.
//

import Foundation
import Alamofire

enum TMDBAPI {
    // 각 케이스를 명시적으로 나누기 위해 열거형을 사용했다!!
    
    case trending
    case popular
    case toprated
    case photo(id: Int)
    case detail(id: Int)
    case recommand(id: Int)
    case credit(id: Int)
    case search(query: String)

    private var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }

    var endPoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL + "trending/tv/day")!
        case .popular:
            return URL(string: baseURL + "tv/popular")!
        case .toprated:
            return URL(string: baseURL + "tv/top_rated")!
        case .photo(let id):
            return URL(string: baseURL + "tv/\(id)/images")!
        case .detail(let id):
            return URL(string: baseURL + "tv/\(id)")!
        case .recommand(let id):
            return URL(string: baseURL + "tv/\(id)/recommendations")!
        case .credit(let id):
            return URL(string: baseURL + "tv/\(id)/aggregate_credits")!
        case .search:
            return URL(string: baseURL + "search/tv")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: HTTPHeaders {
        return ["Authorization":APIKey.tmdb]
    }
    var parameters: Parameters {
        switch self {
        case .trending:
            ["language":"ko-KR"]
        case .popular:
            ["language":"ko-KR"]
        case .toprated:
            ["language":"ko-KR"]
        case .photo:
            [:]
        case .detail:
            ["language":"ko-KR"]
        case .recommand:
            ["language":"ko-KR"]
        case .credit:
            ["language":"ko-KR"]
        case .search(let query):
            ["language":"ko-KR", "query":query]
        }
    }
    

    
}
