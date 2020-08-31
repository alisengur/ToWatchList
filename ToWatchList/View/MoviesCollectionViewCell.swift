//
//  MoviesCollectionViewCell.swift
//  ToWatchList
//
//  Created by Ali Şengür on 23.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - outlets
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    
    //MARK: - Configure cell
    public func configure(with movie: Movie) {
        let path = "https://image.tmdb.org/t/p/original" + movie.posterPath!
        let url = URL(string: path)
        
        DispatchQueue.main.async {
            self.posterImageView.sd_setImage(with: url, completed: nil)
        }
    }
}
