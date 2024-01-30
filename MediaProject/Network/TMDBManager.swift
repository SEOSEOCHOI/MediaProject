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
    
    func fetchTrendingTV(completionHandler: @escaping ([Trending]) -> Void) {
        let url = "https://api.themoviedb.org/3/trending/tv/day?language=ko-KR"
        let header: HTTPHeaders = ["Authorization":APIKey.tmdb]
        
        AF.request(url, headers: header).responseDecodable(of: TrendingModel.self) { response in
            switch response.result {
            case .success(let success):
                print(#function)
                print(success)
                completionHandler(success.trending)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchPopularTV(completionHandler: @escaping ([Popular]) -> Void) {
        let url = "https://api.themoviedb.org/3/tv/popular?language=ko-KR"
        let header: HTTPHeaders = ["Authorization":APIKey.tmdb]
        
        AF.request(url, headers: header).responseDecodable(of: PopularModel.self) { response in
            switch response.result {
            case .success(let success):
                print(#function)
                print(success)
                completionHandler(success.popular)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTopRatedTV(completionHandler: @escaping ([TopRated]) -> Void) {
        let url = "https://api.themoviedb.org/3/tv/top_rated?language=ko-KR"
        let header: HTTPHeaders = ["Authorization":APIKey.tmdb]
        
        AF.request(url, headers: header).responseDecodable(of: TopRatedModel.self) { response in
            switch response.result {
            case .success(let success):
                print(#function)
                print(success)
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
