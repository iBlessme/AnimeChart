//
//  ApiAnimeService.swift
//  AnimBless
//
//  Created by iBlessme on 06.05.2022.
//

import Foundation

// enum - перечисления, определяют общий тип для группы значений
enum ApiServiceError: Error, Equatable{ //протокол equatable сравнивает сущности
    case noResponse
    case urlError
    case jsonDecoderError(error: Error)
    case networkError(error: Error)
    
    //Сравниваем значения
    static func == (lhs: ApiServiceError, rhs: ApiServiceError) -> Bool{
        switch(lhs, rhs){
        case (.noResponse, .noResponse):
            return true
        case (.urlError, .urlError):
            return true
        case (.jsonDecoderError, .jsonDecoderError):
            return true
        case (.networkError, .networkError):
            return true
        default:
            return false
        }
    }
}

//Создаем протокол, описание по работе с API
protocol ApiServiceProtocol {
    func fetchTopAnime(type: String?, page: Int, completionHandler: @escaping (Result<APIGetTopAnime, ApiServiceError>) -> Void)
    func fetchTopManga(type: String?, page: Int, completionHandler: @escaping (Result<APIGetTopManga, ApiServiceError>) -> Void)
}

struct ApiAnimeService: ApiServiceProtocol{
    private let baseURL = "https://api.jikan.moe/v4"
    private let urlSession : URLSession
    
    init(urlSession: URLSession = .shared){
        self.urlSession = urlSession
    }
    
    private func makeURL(point: String, param: String) -> URL?{
        return URL(string: baseURL + "\(point)?\(param)")
    }
    
    private func getRequest<T: Codable>(url: URL, completionHandler: @escaping (Result<T, ApiServiceError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: request){data, response, error in
            if let error = error {
                print("Не удалось подключиться к API")
                completionHandler(.failure(.networkError(error: error)))
                return
            }
            guard let data = data else {
                print("Не получили ответа")
                completionHandler(.failure(.noResponse))
                return
            }
            do {
                let topAnimeList = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(topAnimeList))
            }catch let error{
                completionHandler(.failure(.jsonDecoderError(error: error)))
            }

        }
        .resume()
    }
}
//Создаем расширение для добавления некоторых функций
extension ApiAnimeService{
    func fetchTopAnime(type: String?, page: Int, completionHandler: @escaping (Result<APIGetTopAnime, ApiServiceError>) -> Void) {
        var param = "page=\(page)"
        if let type = type {
            param += "&type\(type)"
        }
        
        guard let url = makeURL(point: "/top/anime", param: param) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        getRequest(url: url, completionHandler: completionHandler)
    }
    
    func fetchTopManga(type: String?, page: Int, completionHandler: @escaping (Result<APIGetTopManga, ApiServiceError>) -> Void) {
        var param = "page=\(page)"
        if let type = type {
            param += "&type\(type)"
        }
        
        guard let url = makeURL(point: "/top/manga", param: param) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        getRequest(url: url, completionHandler: completionHandler)
    }
}
