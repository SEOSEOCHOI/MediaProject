//
//  TMDBManager.swift
//  MediaProject
//
//  Created by 최서경 on 1/30/24.
//

import Foundation
import Alamofire

class TMDBManager {
    static let shared = TMDBManager()
    
    let baseURL = "https://api.themoviedb.org/3/"
    let header: HTTPHeaders = ["Authorization":APIKey.tmdb]
}

extension TMDBManager {
    func fetchTrendingTV(completionHandler: @escaping ([Trending]) -> Void) {
        let url = baseURL + "trending/tv/day?language=ko-KR"
        
        AF.request(url, headers: header).responseDecodable(of: TrendingModel.self) { response in
            switch response.result {
            case .success(let success):

                completionHandler(success.trending)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchPopularTV(completionHandler: @escaping ([Popular]) -> Void) {
        let url = baseURL + "tv/popular?language=ko-KR"
        
        AF.request(url, headers: header).responseDecodable(of: PopularModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.popular)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTopRatedTV(completionHandler: @escaping ([TopRated]) -> Void) {
        let url = baseURL + "tv/top_rated?language=ko-KR"
        
        AF.request(url, headers: header).responseDecodable(of: TopRatedModel.self) { response in
            switch response.result {
            case .success(let success):
                
                completionHandler(success.topRated)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTVImages(id: Int, completionHandler: @escaping (PosterModel) -> Void) {
        let url = "https://api.themoviedb.org/3/tv/\(id)/images"
        let header: HTTPHeaders = ["Authorization":APIKey.tmdb]
        AF.request(url, headers: header).responseDecodable(of: PosterModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print("failure", failure)
            }
        }
    }
}
extension TMDBManager {
    func fetchDetails(id: Int, completionHandler: @escaping (DetailsModel) -> Void) {
        let url = baseURL + "tv/\(id)?language=ko-KR"
        AF.request(url, headers: header).responseDecodable(of: DetailsModel.self) { response in
            switch response.result {
            case .success(let success): 
                completionHandler(success)
            case .failure(let failure):
                print("failure", failure)
            }
        }
    }
    
    func fetchRecommand(id: Int, completionHandler: @escaping ([Recommand]) -> Void) {
        let url = baseURL + "tv/\(id)/recommendations?language=ko-KR"
        AF.request(url, headers: header).responseDecodable(of: RecommandModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print("failure", failure)
            }
        }
    }
    func fetchCredit(id: Int, completionHandler:
                     // 왜 배열로 접근이 안되지 CreditModel?
                     @escaping (CreditModel?) -> Void) {
        let url = baseURL + "tv/\(id)/aggregate_credits?language=ko-KR"
        AF.request(url, headers: header).responseDecodable(of: CreditModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print("failure", failure)
            }
        }
    }
    func fetchSearch(query: String, completionHandler: @escaping ([Search]) -> Void) {
        let url = baseURL + "search/tv?query=\(query)"
        AF.request(url, headers: header).responseDecodable(of: SearchModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print("failure", failure)
            }
        }
    }
}
