//
//  ReviewsViewController.swift
//  ToWatchList
//
//  Created by Ali Şengür on 31.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var reviews = [ReviewResults]()
    var movieId: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                print(reviews)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}





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
