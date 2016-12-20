//
//  Router.swift
//  MovieApp
//
//  Created by Hardik on 19/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import Foundation
import UIKit

class Router {
    
    static func mainStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: Constants.StoryboardName.main, bundle: nil)
    }
    
    static func displayMovieDetails(forMovie movie: Movie, target: UIViewController) {
        let movieDetailsVC = mainStoryBoard().instantiateViewController(withIdentifier: Constants.StoryboardVCID.movieDetailVC) as! MovieDetailsViewController
        movieDetailsVC.movie = movie
        target.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}
