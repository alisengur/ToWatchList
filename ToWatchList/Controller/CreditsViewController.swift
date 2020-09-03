//
//  CreditsViewController.swift
//  ToWatchList
//
//  Created by Ali Şengür on 29.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: - Properties
    var cast = [MovieCast]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var crew = [MovieCrew]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var type: CreditsType?
    var movieId: Int?
    
    
    
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true

        collectionView.delegate = self
        collectionView.dataSource = self
        
        switch type {
        case .cast:
            self.navigationItem.title = "Cast"
            self.loadCast()
        case .crew:
            self.navigationItem.title = "Crew"
            loadCrew()
        case .none:
            self.navigationItem.title = ""
        }
    }
    
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setCollectionViewItemSize()
    }
    
    
    
    //MARK: - private
    //MARK: - setup collection view
    fileprivate func setCollectionViewItemSize(){
        let numberOfItemsPerRow: CGFloat = 2
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

    
    //MARK: - fetch cast
    private func loadCast() {
        
        guard let movieId = movieId else {
            print("id is empty")
            return
        }
        
        let movieRequest = MovieRequest(urlString: "movie")
        movieRequest.getCast(id: movieId) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let cast):
                self?.cast = cast
            }
        }
    }
    
    
    
    //MARK: - fetch crew
    private func loadCrew() {
        guard let movieId = movieId else {
            print("id is empty")
            return
        }
        
        let movieRequest = MovieRequest(urlString: "movie")
        movieRequest.getCrew(id: movieId) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let crew):
                self?.crew = crew
            }
        }
    }
    
    
    
    
}




//MARK: - Collection View Functions
extension CreditsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch type {
        case .cast:
            return cast.count
        case .crew:
            return crew.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch type {
        case .cast:
            if let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditsCollectionViewCell", for: indexPath) as? CreditsCollectionViewCell {
                castCell.configureCastCell(with: self.cast[indexPath.row])
                return castCell
            }
            return UICollectionViewCell()
        case .crew:
            if let crewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditsCollectionViewCell", for: indexPath) as? CreditsCollectionViewCell {
                crewCell.configureCrewCell(with: self.crew[indexPath.row])
                return crewCell
            }
            return UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    
}
