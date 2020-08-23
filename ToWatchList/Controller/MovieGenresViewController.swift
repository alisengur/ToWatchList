//
//  MovieGenresViewController.swift
//  ToWatchList
//
//  Created by Ali Şengür on 21.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit





enum MovieGenres: String {
    case topRated = "top_rated"
    case popular = "popular"
    case nowPlaying = "now_playing"
    case upcoming = "upcoming"
    case latest = "latest"
}




class MovieGenresViewController: UIViewController {

    @IBOutlet weak var topRatedButton: UIButton!
    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var nowPlayingButton: UIButton!
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var latestButton: UIButton!
    
    
    
    var movieGenre: MovieGenres?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        topRatedButton.layer.cornerRadius = 6
        popularButton.layer.cornerRadius = 6
        nowPlayingButton.layer.cornerRadius = 6
        upcomingButton.layer.cornerRadius = 6
        latestButton.layer.cornerRadius = 6
    }
    

    @IBAction func didTapTopRated(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        moviesVC.genre = .topRated
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
    

    @IBAction func didTapPopular(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        moviesVC.genre = .popular
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
    
    
    @IBAction func didTapNowPlaying(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        moviesVC.genre = .nowPlaying
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
    
    
    @IBAction func didTapUpcoming(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        moviesVC.genre = .upcoming
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
    
    
    @IBAction func didTapLatest(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        moviesVC.genre = .latest
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
}
