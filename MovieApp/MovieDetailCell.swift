//
//  MovieDetailCell.swift
//  MovieApp
//
//  Created by Hardik on 20/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {

    func configure(withMovieDetail movieDetail: [String:AnyObject]) {
        self.textLabel?.text = movieDetail.values.first as? String
        self.detailTextLabel?.text = movieDetail.keys.first
    }

}
