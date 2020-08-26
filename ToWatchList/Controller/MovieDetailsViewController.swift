//
//  MovieDetailsViewController.swift
//  ToWatchList
//
//  Created by Ali Şengür on 25.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit
import SDWebImage


class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var movieId: Int?
    var movie: Movie?
    private let movieRequest = MovieRequest(urlString: "movie")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        loadMovie(id: self.movieId!)
    }

    
    
    
    func loadMovie(id: Int) {
        self.movieRequest.getMovieFromId(id: id) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movie):
                DispatchQueue.main.async {
                    self?.setupUI(movie: movie)
                }
            }
        }
    }
    
    
    func setupUI(movie: Movie) {

        guard let backdropPath = movie.backdropPath else { return }
        let path = "https://image.tmdb.org/t/p/original" + backdropPath
        let url = URL(string: path)
        
        self.navigationItem.title = movie.title
        self.backdropImageView.sd_setImage(with: url, completed: nil)
        self.genreLabel.text = "\(movie.genreText)  ·"
        self.releaseDateLabel.text = "\(movie.yearText)  ·"
        self.durationLabel.text = movie.durationText
        self.overviewLabel.text = movie.overview
        self.ratingLabel.text = movie.ratingText
        self.scoreLabel.text = movie.scoreText
    }
    



}
