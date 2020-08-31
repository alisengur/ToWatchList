//
//  MoviesViewController.swift
//  ToWatchList
//
//  Created by Ali Şengür on 23.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var listOfMovies = [Movie]()
    
    
    var genre: MovieGenres?
    var urlString: String = ""
    var movieId: Int? // for similar movies
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true

        
        switch genre {
        case .topRated:
            self.navigationItem.title = "Top Rated"
            getMovie()
        case .popular:
            self.navigationItem.title = "Popular"
            getMovie()
        case .nowPlaying:
            self.navigationItem.title = "Now Playing"
            getMovie()
        case .upcoming:
            self.navigationItem.title = "Upcoming"
            getMovie()
        case .none:
            self.navigationItem.title = "Similar Movies"
            getSimilarMovies()
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setCollectionViewItemSize()
    }
    
    
    
    fileprivate func setCollectionViewItemSize(){
        let numberOfItemsPerRow: CGFloat = 3
        let lineSpacing: CGFloat = 5
        let spacingBetweenItems: CGFloat = 5
        let width = (collectionView.frame.width - (numberOfItemsPerRow - 1) * spacingBetweenItems) / numberOfItemsPerRow
        let height = width * 1.5
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout ///  UICollectionViewFlowLayout have an itemSize
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = spacingBetweenItems
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
    func getMovie() {
        
        switch genre {
        case .topRated:
            self.urlString = MovieGenres.topRated.rawValue
        case .popular:
            self.urlString = MovieGenres.popular.rawValue
        case .nowPlaying:
            self.urlString = MovieGenres.nowPlaying.rawValue
        case .upcoming:
            self.urlString = MovieGenres.upcoming.rawValue
        case .none:
            self.urlString = ""
        }
        
        
        let movieRequest = MovieRequest(urlString: "movie/\(self.urlString)?api_key=\(API_KEY)")
        
        movieRequest.getMovies { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movies):
                self?.listOfMovies = movies
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    
    
    
    func getSimilarMovies() {
        guard let id = movieId else { return }
        self.urlString = "\(id)/similar"
        
        let movieRequest = MovieRequest(urlString: "movie/\(self.urlString)?api_key=\(API_KEY)")
        
        movieRequest.getSimilarMovies { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let similarMovies):
                self?.listOfMovies = similarMovies
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}





extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        let movie = listOfMovies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailsVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
            movieDetailsVC.movieId = listOfMovies[indexPath.row].id!
            self.navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
    
    
    
    
}
