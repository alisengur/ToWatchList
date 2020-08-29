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




struct Movie: Codable {
    let id: Int?
    let title: String?
    let releaseDate: String?
    let voteAverage: Double?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let runtime: Int?
    let genres: [MovieGenre]?
    
    
    var genreText: String {
        genres?.first?.name ?? ""
    }

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var ratingText: String {
        let rating = Int(voteAverage ?? 0.0)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }

    var scoreText: String {
        guard ratingText.count > 0 else {
            return ""
        }
        return "\(ratingText.count)/10"
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Movie.dateFormatter.date(from: releaseDate) else {
            return ""
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return ""
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? ""
    }
    
//    var cast: [MovieCast]? {
//        credits?.cast
//    }
//
//    var crew: [MovieCrew]? {
//        credits?.crew
//    }

    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case runtime
        case genres = "genres"
    }
    
}




struct MovieGenre: Codable {
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
}



struct MovieCredit: Codable {
    let cast: [MovieCast]?
    let crew: [MovieCrew]?
}


struct MovieCast: Codable {
    let id: Int?
    let profilePath: String?
    let character: String?
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, profilePath = "profile_path" , character, name
    }
}


struct MovieCrew: Codable {
    let id: Int?
    let profilePath: String?
    let job: String?
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, profilePath = "profile_path" , job, name
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




struct TVShow: Codable {
    let id: Double
    let name: String
    let originalLanguage: String
    let voteAverage: Double
    let overview: String
    let backdropPath: String
    let posterPath: String
    
    
    private enum CodingKeys: String, CodingKey {
        case id, name, originalLanguage = "original_language", voteAverage = "vote_average", overview, posterPath = "poster_path", backdropPath = "backdrop_path"
    }
}
