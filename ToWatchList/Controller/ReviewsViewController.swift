//
//  ReviewsViewController.swift
//  ToWatchList
//
//  Created by Ali Şengür on 31.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noReviewsLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    //MARK: - Properties
    var reviews = [ReviewResults]()
    var movieId: Int?
    
    
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.isHidden = true
        self.noReviewsLabel.isHidden = true
        self.navigationItem.title = "Reviews"
        
        setupTableViewCell()
        loadReviews()
    }
    
    


    //MARK: - register cell nib
    fileprivate func setupTableViewCell() {
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "ReviewsTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "ReviewsTableViewCell")
    }

    
    
    
    //MARK: - fetching reviews from api
    private func loadReviews() {
        if let spinner = spinner {
            spinner.startAnimating()
        }
        
        guard let movieId = movieId else {
            return
        }
        
        let movieRequest = MovieRequest(urlString: "movie")
        movieRequest.getReviews(id: movieId) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let reviews):
                self?.reviews = reviews
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            }
        }
    }
    
    
    
    //MARK: - Update UI
    func updateUI() {
        guard let spinner = self.spinner else {
            return
        }
        
        if reviews.isEmpty {
            spinner.removeFromSuperview()
            self.noReviewsLabel.isHidden = false
            self.tableView.isHidden = true
        } else {
            spinner.removeFromSuperview()
            self.noReviewsLabel.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}





//MARK: - Table View Functions
extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let reviewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as? ReviewsTableViewCell {
            if let author = reviews[indexPath.row].author, let content = reviews[indexPath.row].content {
                reviewCell.configureCell(author: author, content: content)
                return reviewCell
            }
        }
        return UITableViewCell()
    }
    
    

    
    
}
