//
//  Movie.swift
//  ToWatchList
//
//  Created by Ali Şengür on 18.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import Foundation



struct APIResults: Codable {
    let page: Int
    let numResults: Int
    let numPages: Int
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page, numResults = "total_results", numPages = "total_pages", movies = "results"
    }
}




struct Movie: Codable {
    var title: String
    var releaseDate: String
    var voteAverage: Double
    var posterPath: String
    var backdropPath: String
    
    
    private enum CodingKeys: String, CodingKey {
        case title, releaseDate = "release_date", voteAverage = "vote_average", posterPath = "poster_path", backdropPath = "backdrop_path"
    }
    
    
//    init(from decoder: Decoder) throws {
//        let movies = try decoder.container(keyedBy: CodingKeys.self)
//        title = try movies.decode(String.self, forKey: .title)
//        releaseDate = try movies.decode(String.self, forKey: .releaseDate)
//        voteAverage = try movies.decode(Double.self, forKey: .voteAverage)
//        posterPath = try movies.decode(String.self, forKey: .posterPath)
//        backdropPath = try movies.decode(String.self, forKey: .)
//    }

}
