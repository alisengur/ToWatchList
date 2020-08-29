//
//  TVShowsCollectionViewCell.swift
//  ToWatchList
//
//  Created by Ali Şengür on 27.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit

class TVShowsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    public func configure(with tvShow: TVShow) {

        let path = "https://image.tmdb.org/t/p/original" + tvShow.posterPath

        let url = URL(string: path)
        
        DispatchQueue.main.async {
            self.posterImageView.sd_setImage(with: url, completed: nil)
        }

    }
    
}
