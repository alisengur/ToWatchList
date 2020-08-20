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
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setTableView()
        getMovie()
    }
    
    
    fileprivate func setTableView() {
        let moviesTableViewCell = UINib(nibName: "MoviesTableViewCell", bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(moviesTableViewCell, forCellReuseIdentifier: "MoviesTableViewCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        let movie = listOfMovies[indexPath.row]
        cell.configure(with: movie)
        return cell

    }
    
}
