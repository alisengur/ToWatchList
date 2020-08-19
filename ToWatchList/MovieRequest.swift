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
    let apiKey = API_KEY
    
    
    init() {
        let resourceString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        guard let resourceUrl = URL(string: resourceString) else {
            fatalError()
        }
        self.resourceUrl = resourceUrl
    }
    
    
    func getMovies(completion: @escaping(Result<[TopRatedMovie], MovieError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceUrl) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let moviesResponse = try decoder.decode(APIResults.self, from: jsonData)
                print(moviesResponse)
                let movieDetails = moviesResponse.movies
                completion(.success(movieDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
    
    
    
}
