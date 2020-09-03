//
//  CreditsCollectionViewCell.swift
//  ToWatchList
//
//  Created by Ali Şengür on 29.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit
import SDWebImage


class CreditsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!

    
    

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        characterLabel.text = nil
        imageView.image = nil
    }
    
    
    
    
    //MARK: - Configure cell for the cast
    public func configureCastCell(with cast: MovieCast) {

        guard let profilePath = cast.profilePath else {
            return
        }
        
        let path = "https://image.tmdb.org/t/p/original" + profilePath
        if let profileUrl = URL(string: path) {
            DispatchQueue.main.async {
                self.imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                self.imageView.sd_setImage(with: profileUrl, completed: nil)
                self.nameLabel.text = cast.name
                self.characterLabel.text = cast.character
            }
        }
    }
    
    
    
    
    //MARK: - Configure cell for crew
    public func configureCrewCell(with crew: MovieCrew) {
        
        guard let profilePath = crew.profilePath else {
            return
        }
        let path = "https://image.tmdb.org/t/p/original" + profilePath
        if let profileUrl = URL(string: path) {
            DispatchQueue.main.async {
                self.imageView.sd_setImage(with: profileUrl, completed: nil)
                self.nameLabel.text = crew.name
                self.characterLabel.text = crew.job
            }
        }
        
    }

    
}
