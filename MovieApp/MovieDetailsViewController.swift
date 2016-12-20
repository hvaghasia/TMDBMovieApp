//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Hardik on 19/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var movieImageView: UIImageView!
    var movie: Movie?
    var dataProvider: MovieDataProvider?
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.center = self.movieImageView.center
        return activityView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    //configure views
    func configureView() {
        dataProvider = MovieDataProvider(cellIdentifier: Constants.CellIndentifier.movieDetailCell, cellConfigurationBlock: { (movieItem, cell) in
            if let movieDetails = movieItem as? [String:AnyObject], let movieDetailCell = cell as? MovieDetailCell {
                movieDetailCell.configure(withMovieDetail: movieDetails)
            }
        })
        dataProvider?.tableView = tableView
        
        if let movieObj = movie {
            //Fetch movie details from server
            dataProvider?.fetchMovieDetails(forMovieId: movieObj.id) { [weak self] (movie, error) in
                self?.movie = movie
            }
            
            if let posterPath = movieObj.posterPath {
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()

                //Fetch movie poster image
                NetworkManager.sharedManager.getMoviePoster(withPosterPath: posterPath, posterSize: Constants.MoviePosterImageSize.movieDetail, completionHandler: { [weak self] (moviePosterData, error) in
                    
                    if let posterData = moviePosterData, let image = UIImage(data: posterData) {
                        DispatchQueue.main.async {
                            self?.activityIndicator.stopAnimating()
                            self?.movieImageView.image = image
                        }
                    }
                })
            } else {
                movieImageView.image = UIImage(named: Constants.moviePosterPlaceholderImageName)
            }
        }
        tableView.tableFooterView = UIView() // to remove extra empty rows
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
