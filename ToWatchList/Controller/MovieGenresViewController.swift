//
//  MovieGenresViewController.swift
//  ToWatchList
//
//  Created by Ali Şengür on 21.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit


//MARK: - To determine which movies will be fetch from api
enum MovieGenres: String {
    case topRated = "top_rated"
    case popular = "popular"
    case nowPlaying = "now_playing"
    case upcoming = "upcoming"
}





class MovieGenresViewController: UIViewController {

    
    //MARK: - Outlets
    @IBOutlet weak var topRatedButton: UIButton!
    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var nowPlayingButton: UIButton!
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var movieGenre: MovieGenres?
    
    var listOfMovies = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()


        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]


        
        topRatedButton.layer.cornerRadius = 6
        popularButton.layer.cornerRadius = 6
        nowPlayingButton.layer.cornerRadius = 6
        upcomingButton.layer.cornerRadius = 6
        
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
    }
    

    
    
    
    
    
    //MARK: - Actions
    @IBAction func didTapTopRated(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        moviesVC.genre = .topRated
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
    

    @IBAction func didTapPopular(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        moviesVC.genre = .popular
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
    
    
    @IBAction func didTapNowPlaying(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        moviesVC.genre = .nowPlaying
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
    
    
    @IBAction func didTapUpcoming(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        moviesVC.genre = .upcoming
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
}







//MARK: - UISearchBarDelegate
extension MovieGenresViewController: UISearchBarDelegate {
    
    
    
    //MARK: - works when tapped enter button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /// editing the query text with space characters converted to plus character
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "+").isEmpty else {
            return
        }
        searchBar.resignFirstResponder()
        
        let movieRequest = MovieRequest(urlString: "search/movie?api_key=\(API_KEY)&query=\(text)")

        
        /// Searching movies with query text that entered
        movieRequest.searchMovies(query: text) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movies):
                self?.listOfMovies = movies
                
                /// Update UI on main thread if searching succeeds
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            }
        }
    }
    
    
    
    
    //MARK: - works when text did change in search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        /// editing the query text with space characters converted to plus character
        let editedText = searchText.replacingOccurrences(of: " ", with: "+")
        let movieRequest = MovieRequest(urlString: "search/movie?api_key=\(API_KEY)&query=\(editedText)")

        movieRequest.searchMovies(query: editedText) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movies):
                self?.listOfMovies = movies
                
                /// Update UI on main thread if searching succeeds
                DispatchQueue.main.async {
                    self?.updateUI()
                }
                
            }

        }
    }
    
    

    
    
    //MARK: - Update UI
    func updateUI() {
        if listOfMovies.isEmpty {
            self.tableView.isHidden = true
        } else {
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}






//MARK: - Table View Functions
extension MovieGenresViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieCell", for: indexPath)
        cell.textLabel?.text = listOfMovies[indexPath.row].title
        cell.detailTextLabel?.text = listOfMovies[indexPath.row].releaseDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailsVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
            movieDetailsVC.movieId = listOfMovies[indexPath.row].id
            self.navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
    
    
}
