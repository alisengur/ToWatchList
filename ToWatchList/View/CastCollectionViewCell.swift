//
//  CastCollectionViewCell.swift
//  ToWatchList
//
//  Created by Ali Şengür on 27.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit
import SDWebImage


class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    var task: URLSessionDataTask!
    
    
    

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        characterLabel.text = nil
        imageView.image = nil
    }
    
    
    
    
    public func configureCastCell(with cast: MovieCast) {
        
        if let spinner = spinner {
            spinner.startAnimating()
        }
        
        guard let profilePath = cast.profilePath else {
            return
        }
        let path = "https://image.tmdb.org/t/p/original" + profilePath
        if let profileUrl = URL(string: path) {
            loadProfileImage(from: profileUrl)
        }
        
        self.nameLabel.text = cast.name
        self.characterLabel.text = cast.character
        
    }
    
    
    public func configureCrewCell(with crew: MovieCrew) {
        
        if let spinner = spinner {
            spinner.startAnimating()
        }
        
        guard let profilePath = crew.profilePath else {
            return
        }
        let path = "https://image.tmdb.org/t/p/original" + profilePath
        if let profileUrl = URL(string: path) {
            loadProfileImage(from: profileUrl)
        }
        
        self.nameLabel.text = crew.name
        self.characterLabel.text = crew.job
        
    }
    
    
    
    
    func loadProfileImage(from url: URL) {
        if let task = task {
            task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.imageView.image = imageFromCache
            if let spinner = self.spinner {
                spinner.removeFromSuperview()
                return
            }
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                let profileImage = UIImage(data: data) else {
                    print("couldn't load image from url: \(url)")
                    return
            }
            
            self.imageCache.setObject(profileImage, forKey: url.absoluteString as AnyObject)

            DispatchQueue.main.async {
                self.imageView.image = profileImage
                if let spinner = self.spinner {
                    spinner.removeFromSuperview()
                }

            }
        }
        dataTask.resume()
    }
}
