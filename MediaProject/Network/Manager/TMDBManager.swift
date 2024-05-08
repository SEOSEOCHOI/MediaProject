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
    
    func request<T: Decodable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping (T) -> Void) {
        
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameters,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTVShow(api: TMDBAPI,completionHandler: @escaping (TVShowModel) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameters,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: TVShowModel.self) { response in
            switch response.result {
            case .success(let success):
                
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTVImages(api: TMDBAPI, completionHandler: @escaping (PosterModel) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   headers: api.header).responseDecodable(of: PosterModel.self) { response in
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
    func fetchDetails(api: TMDBAPI, completionHandler: @escaping (DetailsModel) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameters,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: DetailsModel.self) { response in
            switch response.result {
            case .success(let success): 
                completionHandler(success)
            case .failure(let failure):
                print("failure", failure)
            }
        }
    }
    
    func fetchRecommand(api: TMDBAPI, completionHandler: @escaping ([Recommand]) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameters,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: RecommandModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print("failure", failure)
            }
        }
    }
    func fetchCredit(api: TMDBAPI, completionHandler:
                     @escaping (CreditModel) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameters,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: CreditModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.self)
            case .failure(let failure):
                print("failure", failure)
            }
        }
    }
    func fetchSearch(api: TMDBAPI, completionHandler: @escaping ([Search]) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameters,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: SearchModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print("failure", failure)
            }
        }
    }
}
