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
    
    
    var resourceUrl: URL?
    var resourceUrlString: String?
    
    
    
    init(urlString: String) {
        let baseUrlString = "https://api.themoviedb.org/3/\(urlString)"
        self.resourceUrlString = baseUrlString
    }
    
    
    func getMovies(completion: @escaping(Result<[Movie], MovieError>) -> Void) {
        guard let finalUrl = URL(string: resourceUrlString!) else {
            fatalError()
        }
        let dataTask = URLSession.shared.dataTask(with: finalUrl) { data, _, _ in
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
    
    
    
    func getMovieFromId(id: Int, completion: @escaping(Result<Movie, MovieError>) -> Void) {
        let finalUrlString = "\(resourceUrlString!)/\(id)?api_key=\(API_KEY)"
        guard let finalUrl = URL(string: finalUrlString) else {
            fatalError()
        }
        
        let dataTask = URLSession.shared.dataTask(with: finalUrl) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(Movie.self, from: jsonData)
                let movie = movieResponse
                completion(.success(movie))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()

    }
    
    
    
    func getCast(id: Int, completion: @escaping(Result<[MovieCast], MovieError>) -> Void) {
        

        
        let finalUrlString = "\(resourceUrlString!)/\(id)/credits?api_key=\(API_KEY)"
        print(finalUrlString)
        guard let finalUrl = URL(string: finalUrlString) else {
            fatalError()
        }
        
        let dataTask = URLSession.shared.dataTask(with: finalUrl) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieCredit.self, from: jsonData)
                let movieCast = movieResponse.cast ?? []
                completion(.success(movieCast))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }

        dataTask.resume()
    }
    
    
    
    func getCrew(id: Int, completion: @escaping(Result<[MovieCrew], MovieError>) -> Void) {
        

        
        let finalUrlString = "\(resourceUrlString!)/\(id)/credits?api_key=\(API_KEY)"
        print(finalUrlString)
        guard let finalUrl = URL(string: finalUrlString) else {
            fatalError()
        }
        
        let dataTask = URLSession.shared.dataTask(with: finalUrl) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieCredit.self, from: jsonData)
                let movieCrew = movieResponse.crew ?? []
                completion(.success(movieCrew))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }

        dataTask.resume()
    }
    
    
    
    
    func searchMovies(query: String, completion: @escaping(Result<[Movie], MovieError>) -> Void) {
        guard let resourceUrlString = resourceUrlString else { return }
        guard let resourceUrl = URL(string: resourceUrlString) else {
            fatalError()
        }
        let dataTask = URLSession.shared.dataTask(with: resourceUrl) { data, _, _ in
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
        guard let resourceUrl = self.resourceUrl else { return }
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
