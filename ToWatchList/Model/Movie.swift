//
//  Movie.swift
//  ToWatchList
//
//  Created by Ali Şengür on 18.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import Foundation



struct MovieResults: Codable {
    let page: Int?
    let numResults: Int?
    let numPages: Int?
    let movies: [Movie]?
    
    private enum CodingKeys: String, CodingKey {
        case page, numResults = "total_results", numPages = "total_pages", movies = "results"
    }
}


struct TVShowResults: Codable {
    let page: Int
    let numResults: Int
    let numPages: Int
    let tvShows: [TVShow]
    
    private enum CodingKeys: String, CodingKey {
        case page, numResults = "total_results", numPages = "total_pages", tvShows = "results"
    }
}



struct Movie: Codable {
    var id: Double?
    var title: String?
    var releaseDate: String?
    var voteAverage: Double?
    var overview: String?
    var posterPath: String?
    var backdropPath: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case id, title, releaseDate = "release_date", voteAverage = "vote_average", overview, posterPath = "poster_path", backdropPath = "backdrop_path"
    }

}



struct TVShow: Codable {
    var id: Double
    var name: String
    var originalLanguage: String
    var voteAverage: Double
    var overview: String
    var backdropPath: String
    var posterPath: String
    
    
    private enum CodingKeys: String, CodingKey {
        case id, name, originalLanguage = "original_language", voteAverage = "vote_average", overview, posterPath = "poster_path", backdropPath = "backdrop_path"
    }
}
