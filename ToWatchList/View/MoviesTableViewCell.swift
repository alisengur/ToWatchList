//
//  MoviesTableViewCell.swift
//  ToWatchList
//
//  Created by Ali Şengür on 20.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit
import SDWebImage


class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var goToDetailsButton: UIButton!
    @IBOutlet weak var addToListButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    public func configure(with movie: TopRatedMovie) {
        self.nameTitleLabel.text = movie.title
        self.releaseDateLabel.text = movie.releaseDate
        
        let path = "https://image.tmdb.org/t/p/original" + movie.posterPath
        print(path)

        let url = URL(string: path)
        
        DispatchQueue.main.async {
            self.posterImageView.sd_setImage(with: url, completed: nil)
        }

    }
    

    
    

    
    
}
