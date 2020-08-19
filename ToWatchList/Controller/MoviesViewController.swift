//
//  MoviesViewController.swift
//  ToWatchList
//
//  Created by Ali Şengür on 18.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var listOfMovies = [TopRatedMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfMovies.count) movies found"
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getMovie()
    }
    
    
    func getMovie() {
        let movieRequest = MovieRequest()
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



extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let movie = listOfMovies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel? .text = movie.releaseDate
        return cell

    }
    
}
