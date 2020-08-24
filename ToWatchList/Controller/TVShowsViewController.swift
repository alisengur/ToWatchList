//
//  TVShowsViewController.swift
//  ToWatchList
//
//  Created by Ali Şengür on 23.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit

class TVShowsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var listOfTVShows = [TVShow]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    
    var genre: TVShowGenres?
    var urlString: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        switch genre {
        case .popular:
            self.navigationItem.title = "Popular"
        case .airingToday:
            self.navigationItem.title = "Airing Today"
        case .onTv:
            self.navigationItem.title = "On TV"
        case .topRated:
            self.navigationItem.title = "Top Rated"
        case .none:
            self.navigationItem.title = "Top Rated"
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        getTVShow()
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

    
    
    
    func getTVShow() {
        
        switch genre {
        case .popular:
            self.urlString = TVShowGenres.popular.rawValue
        case .airingToday:
            self.urlString = TVShowGenres.airingToday.rawValue
        case .onTv:
            self.urlString = TVShowGenres.onTv.rawValue
        case .topRated:
            self.urlString = TVShowGenres.topRated.rawValue
        case .none:
            self.urlString = MovieGenres.topRated.rawValue
        }
        
        
        let movieRequest = MovieRequest(urlString: "tv/\(self.urlString)?api_key=\(API_KEY)")
        
        movieRequest.getTVShows { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let tvShows):
                self?.listOfTVShows = tvShows
            }
        }
    }

}






extension TVShowsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfTVShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowsCollectionViewCell", for: indexPath) as! TVShowsCollectionViewCell
        let tvShow = listOfTVShows[indexPath.row]
        print(tvShow.posterPath)
        cell.configure(with: tvShow)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
}
