//
//  MovieListCell.swift
//  MovieApp
//
//  Created by Hardik on 19/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {
    
    func configure(withMovie movie: Movie) {
        self.textLabel?.text = movie.title
        self.imageView?.image = UIImage(named: Constants.moviePosterPlaceholderImageName)
        
        if let posterPath = movie.posterPath {
            NetworkManager.sharedManager.getMoviePoster(withPosterPath: posterPath, posterSize: Constants.MoviePosterImageSize.thumbnail, completionHandler: { [weak self] (moviePosterData, error) in
                if let posterData = moviePosterData, let image = UIImage(data: posterData) {
                    DispatchQueue.main.async { [weak self] in
                        self?.imageView?.image = image
                    }
                }
            })
        }
    }
}
