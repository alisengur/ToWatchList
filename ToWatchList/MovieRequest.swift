//
//  MovieRequest.swift
//  ToWatchList
//
//  Created by Ali Şengür on 18.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import Foundation



enum MovieError: Error {
    case noDataAvailable
    case canNotProcessData
}


struct MovieRequest {
    
    let resourceUrl: URL
    
    
    init(urlString: String) {
        let baseUrlString = "https://api.themoviedb.org/3/"
        let resourceUrlString = baseUrlString + urlString
        print()
        guard let resourceUrl = URL(string: resourceUrlString) else {
            fatalError()
        }
        self.resourceUrl = resourceUrl
    }
    
    
    func getMovies(completion: @escaping(Result<[Movie], MovieError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceUrl) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let moviesResponse = try decoder.decode(MovieResults.self, from: jsonData)
                print(moviesResponse)
                let movieDetails = moviesResponse.movies ?? []
                completion(.success(movieDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
    
    
    
    
    func searchMovies(query: String, completion: @escaping(Result<[Movie], MovieError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: self.resourceUrl) { data, _, _ in
            print("Resource url for search movie: \(self.resourceUrl)")
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let moviesResponse = try decoder.decode(MovieResults.self, from: jsonData)
                let movieDetails = moviesResponse.movies ?? []
                completion(.success(movieDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    
    
    func getTVShows(completion: @escaping(Result<[TVShow], MovieError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceUrl) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let tvShowResponse = try decoder.decode(TVShowResults.self, from: jsonData)
                print(tvShowResponse)
                let tvShowDetails = tvShowResponse.tvShows
                completion(.success(tvShowDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
    
}
