//
//  MovieDetailsViewController.swift
//  ToWatchList
//
//  Created by Ali Şengür on 25.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit
import SDWebImage



enum CreditsType: String {
    case cast
    case crew
}



class MovieDetailsViewController: UIViewController {

    
    //MARK: - outlets
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    private let movieRequest = MovieRequest(urlString: "movie")
    var movieId: Int?
    var movie: Movie?
    var castArray = [MovieCast]()
    
    
    
    //MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        loadMovie(id: self.movieId!)
    }

    
    
    
    private func loadMovie(id: Int) {
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
    
    
    private func setupUI(movie: Movie) {

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
        self.scoreLabel.text = "\(movie.voteAverage!)"
    }
    


    
    
    //MARK: - actions
    @IBAction func didTapCastButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let creditsVC = storyboard.instantiateViewController(withIdentifier: "CreditsViewController") as? CreditsViewController{
            creditsVC.type = .cast
            creditsVC.movieId = movieId
            self.navigationController?.pushViewController(creditsVC, animated: true)
        }
        
    }
    
    @IBAction func didTapCrewButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let creditsVC = storyboard.instantiateViewController(withIdentifier: "CreditsViewController") as? CreditsViewController{
            creditsVC.type = .crew
            creditsVC.movieId = movieId
            self.navigationController?.pushViewController(creditsVC, animated: true)
        }
    }
    
    
    
    @IBAction func didTapReviewsButton(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let reviewsVC = storyboard.instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController {
            reviewsVC.movieId = movieId
            self.navigationController?.pushViewController(reviewsVC, animated: true)
        }
        
    }
    
    @IBAction func didTapSimilarButton(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let similarMoviesVC = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        similarMoviesVC.movieId = movieId
        self.navigationController?.pushViewController(similarMoviesVC, animated: true)
        
    }
}
