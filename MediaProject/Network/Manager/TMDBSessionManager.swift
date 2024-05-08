//
//  TMDBSessionManager.swift
//  MediaProject
//
//  Created by 최서경 on 2/5/24.
//

import Foundation

enum SeSACError: Error {
    case failedRequset
    case noData
    case invaildResponse
    case invaildData
}

class TMDBSessionManager {
    static let shared = TMDBSessionManager()
    
    func fetchTMDBAsyncAwait<T: Decodable>(type: T.Type, api: TMDBAPI) async throws -> T {
        var url = URLRequest(url: api.endPoint)
        url.httpMethod = "GET"
        url.addValue(APIKey.tmdb, forHTTPHeaderField: "Authorization")
        
        // 응답이 오기 전까지 대기.
        let (data, response) = try await URLSession.shared.data(for: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw SeSACError.invaildResponse
        }
        guard response.statusCode == 200 else {
            throw SeSACError.invaildData
        }
        
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
        
    }

    // Trending
    func fetchTrendingModel(completionHandelr: @escaping (TVShowModel?, SeSACError?) -> Void) {
        var url = URLRequest(url: TMDBAPI.trending.endPoint)
        url.httpMethod = "GET"
        url.addValue(APIKey.tmdb, forHTTPHeaderField: "Authorization")
        
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                
                //print("data: ", data)
                print("response: ", response)
                print("error: ", error)
                
                guard error == nil else {
                    completionHandelr(nil, .failedRequset)
                    return
                }
                guard let data = data else {
                    completionHandelr(nil, .noData)
                    return
                }
                print("data: ",String(data: data, encoding: .utf8))

                guard let response = response as? HTTPURLResponse else { // Status Code
                    print("통신은 성공했지만, 응답값(ex. 상태코드)이 오지 않음.")
                    completionHandelr(nil, .invaildResponse)
                    return
                }
                guard response.statusCode == 200 else {
                    print("통신은 성공했지만, 올바른 값이 오지 않은 상태.")
                    completionHandelr(nil, .invaildResponse)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(TVShowModel.self, from: data)
                    completionHandelr(result, nil)
                } catch {
                    completionHandelr(nil, .invaildData)
                }
            }
            
        }.resume()
    }
    // Popular
    func fetchPopularModel(completionHandler: @escaping(TVShowModel?, SeSACError?) -> Void) {
        var url = URLRequest(url: TMDBAPI.popular.endPoint)
        url.httpMethod = "GET"
        url.addValue(APIKey.tmdb, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completionHandler(nil, .failedRequset)
                    return
                }
                guard let data = data else {
                    completionHandler(nil, .noData)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, .invaildResponse)
                    return
                }
                guard response.statusCode == 200 else {
                    completionHandler(nil, .invaildResponse)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(TVShowModel.self, from: data)
                    completionHandler(result, nil)
                } catch {
                    completionHandler(nil, .invaildData)
                }
            }
        }.resume()
    }
    
    func fetchTopRatedModel(completionHandler: @escaping (TVShowModel?, SeSACError?) -> Void) {
        var url = URLRequest(url: TMDBAPI.toprated.endPoint)
        url.httpMethod = "GET"
        url.addValue(APIKey.tmdb, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completionHandler(nil, .failedRequset)
                    return
                }
                guard let data = data else {
                    completionHandler(nil, .noData)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, .invaildResponse)
                    return
                }
                guard response.statusCode == 200 else {
                    completionHandler(nil, .invaildResponse)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(TVShowModel.self, from: data)
                    completionHandler(result, nil)
                } catch {
                    completionHandler(nil, .invaildData)
                }
            }
        }.resume()
    }
}
