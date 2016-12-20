//
//  MovieDataProvider.swift
//  MovieApp
//
//  Created by Hardik on 19/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import Foundation
import UIKit

typealias CellConfigurationBlock = (_ item: AnyObject, _ cell: AnyObject) -> Void

class MovieDataProvider: NSObject {
    
    var items = [AnyObject]()
    var cellIdentifier: String?
    weak public var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    var cellConfigurationBlock: CellConfigurationBlock?
    
    init(cellIdentifier identifier: String, cellConfigurationBlock block: @escaping CellConfigurationBlock) {
        self.cellIdentifier = identifier
        self.cellConfigurationBlock = block
        super.init()
    }
    
    func resetData() {
        items = [AnyObject]()
        AppState.sharedState.resetPageDetails()
    }
    
    //Fetch movie list according to given page no, sort descriptor and min/max year filter
    func fetchMovies(forPageNo pageNo: Int = 1, sortedBy sortType: Constants.MovieListSortType = .latest, filter: Filter? = nil) {
        let sortingMode = filter?.sortingMode ?? .latest
        NetworkManager.sharedManager.getMovies(forPageNo: pageNo, sortedBy: sortingMode, filterMinYear: filter?.minYear, filterMaxYear: filter?.maxYear) { [weak self] (fetchedMovies, error: Error?) in
            if let movies  = fetchedMovies {
                self?.items.append(contentsOf: movies)
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.tableHeaderView = nil
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    //Fetch movie details for given movie id
    func fetchMovieDetails(forMovieId movieId: Int, completionHandler: MovieDetailsCompletionHandler) {
        NetworkManager.sharedManager.getMovieDetails(forMovieId: movieId) { [weak self] (fetchedMovie, error) in
            print("Movie details: \(fetchedMovie)")
            
            if let movie = fetchedMovie {
                self?.items.append([Constants.MovieDetailTableViewCellTitle.title : movie.title] as AnyObject)
                self?.items.append([Constants.MovieDetailTableViewCellTitle.releaseDate : movie.releaseDate] as AnyObject)
                if movie.voteCount > 0 {
                    self?.items.append([Constants.MovieDetailTableViewCellTitle.vote : String(movie.vote)] as AnyObject)
                    self?.items.append([Constants.MovieDetailTableViewCellTitle.voteCount : String(movie.voteCount)] as AnyObject)
                }
                
                if let tagLine = movie.tagLine, !tagLine.isEmpty {
                    self?.items.append([Constants.MovieDetailTableViewCellTitle.tagline : tagLine] as AnyObject)
                }
                
                if let budget = movie.budget, budget > 0 {
                    self?.items.append([Constants.MovieDetailTableViewCellTitle.budget : String(budget)] as AnyObject)
                }
                
                if let revenue = movie.revenue, revenue > 0 {
                    self?.items.append([Constants.MovieDetailTableViewCellTitle.revenue : String(revenue)] as AnyObject)
                }
                self?.items.append([Constants.MovieDetailTableViewCellTitle.adult : String(movie.isAdult)] as AnyObject)
                self?.items.append([Constants.MovieDetailTableViewCellTitle.language : movie.language] as AnyObject)

                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension MovieDataProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)
        let movie = items[indexPath.row]
        cellConfigurationBlock?(movie, cell)
        return cell
    }
}
