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
    let movies: [TopRatedMovie]
    
    private enum CodingKeys: String, CodingKey {
        case page, numResults = "total_results", numPages = "total_pages", movies = "results"
    }
}




struct TopRatedMovie: Codable {
    var title: String
    var releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
        case title, releaseDate = "release_date"
    }

}
