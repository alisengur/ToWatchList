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
    
    var listOfMovies = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    var genre: MovieGenres?
    var urlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        switch genre {
        case .topRated:
            self.navigationItem.title = "Top Rated"
        case .popular:
            self.navigationItem.title = "Popular"
        case .nowPlaying:
            self.navigationItem.title = "Now Playing"
        case .upcoming:
            self.navigationItem.title = "Upcoming"
        case .latest:
            self.navigationItem.title = "Latest"
        case .none:
            self.navigationItem.title = "Top Rated"
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        getMovie()
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
        case .latest:
            self.urlString = MovieGenres.latest.rawValue
        case .none:
            self.urlString = MovieGenres.topRated.rawValue
        }
        
        
        let movieRequest = MovieRequest(urlString: self.urlString)
        
        movieRequest.getMovies { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movies):
                self?.listOfMovies = movies
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
        print(movie.posterPath)
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
}
