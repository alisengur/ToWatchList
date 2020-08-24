//
//  TVShowGenresViewController.swift
//  ToWatchList
//
//  Created by Ali Şengür on 23.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit


enum TVShowGenres: String {
    case popular = "popular"
    case airingToday = "airing_today"
    case onTv = "on_the_air"
    case topRated = "top_rated"
}



class TVShowGenresViewController: UIViewController {

    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var airingTodayButton: UIButton!
    @IBOutlet weak var onTVButton: UIButton!
    @IBOutlet weak var topRatedButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "TV Shows"
        
        popularButton.layer.cornerRadius = 6
        airingTodayButton.layer.cornerRadius = 6
        onTVButton.layer.cornerRadius = 6
        topRatedButton.layer.cornerRadius = 6
    }
    

    @IBAction func didTapPopular(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tvShowsVC = storyboard.instantiateViewController(withIdentifier: "TVShowsViewController") as! TVShowsViewController
        tvShowsVC.genre = .popular
        self.navigationController?.pushViewController(tvShowsVC, animated: true)
    }
    
    
    @IBAction func didTapAiringToday(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tvShowsVC = storyboard.instantiateViewController(withIdentifier: "TVShowsViewController") as! TVShowsViewController
        tvShowsVC.genre = .airingToday
        self.navigationController?.pushViewController(tvShowsVC, animated: true)
    }
    
    
    @IBAction func didTapOnTV(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tvShowsVC = storyboard.instantiateViewController(withIdentifier: "TVShowsViewController") as! TVShowsViewController
        tvShowsVC.genre = .onTv
        self.navigationController?.pushViewController(tvShowsVC, animated: true)
    }
    

    @IBAction func didTapTopRated(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tvShowsVC = storyboard.instantiateViewController(withIdentifier: "TVShowsViewController") as! TVShowsViewController
        tvShowsVC.genre = .topRated
        self.navigationController?.pushViewController(tvShowsVC, animated: true)
    }
}
