//
//  ViewController.swift
//  MovieApp
//
//  Created by Hardik on 19/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import UIKit

class MovieListViewController: UITableViewController {
    var dataProvider: MovieDataProvider?
    var selectedMovie: Movie?
    var filter: Filter?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.ScreenTitle.movieList
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Configure Tableview to display movie list
    func configureTableView() {
        dataProvider = MovieDataProvider(cellIdentifier: Constants.CellIndentifier.movieListCell, cellConfigurationBlock: { (movieItem, cell) in
            if let movie = movieItem as? Movie, let movieListCell = cell as? MovieListCell {
                movieListCell.configure(withMovie: movie)
            }
        })
        dataProvider?.tableView = tableView
        dataProvider?.fetchMovies()
        
        tableView.tableFooterView = UIView() // to remove extra empty rows
    }
    
    //Display view to add min and max year to filter movies
    @IBAction func filterButtonTapped(_ sender: Any) {
        let filterAlertVC = UIAlertController(title: Constants.MovieFilterAlertView.message, message: nil, preferredStyle: .alert)
        filterAlertVC.addAction(UIAlertAction(title: Constants.MovieFilterAlertView.filterButtonTitle, style: .default, handler: { [weak self] (action) in
            if let minYearTxtField = filterAlertVC.textFields?.first, let minYearValue = minYearTxtField.text, !minYearValue.isEmpty, let maxYearTxtField = filterAlertVC.textFields?.last, let maxYearValue = maxYearTxtField.text, !maxYearValue.isEmpty {
                
                self?.filter = Filter(minYearValue: minYearValue, maxYearValue: maxYearValue)
                self?.dataProvider?.resetData()
                self?.addTableViewHeader() // Display Loading view to give hind to user
                // Fetch movies according to filter applied
                self?.dataProvider?.fetchMovies(filter: self?.filter)
            } else {
                //Display error if filter values are not valid
                self?.showAlert(withTitle: nil, message: Constants.MovieFilterErrorAlertView.missingValue, buttonTitle: Constants.MovieFilterErrorAlertView.buttonTitle)
                return
            }
        }))
        filterAlertVC.addAction(UIAlertAction(title: Constants.MovieFilterAlertView.cancelButtonTitle, style: .default, handler: nil))
        
        filterAlertVC.addTextField { (minYearTextField) in
            minYearTextField.placeholder = Constants.MovieFilterAlertView.minYearTxtFieldPlaceholder
            minYearTextField.keyboardType = .numberPad
        }
        filterAlertVC.addTextField { (maxYearTextField) in
            maxYearTextField.placeholder = Constants.MovieFilterAlertView.maxYearTxtFieldPlaceholder
            maxYearTextField.keyboardType = .numberPad
        }
        self.present(filterAlertVC, animated: true, completion: nil)
    }
    
    //Remove applied filter of min and max year
    @IBAction func resetFilterButtonTapped(_ sender: Any) {
        filter = nil
        dataProvider?.resetData()
        dataProvider?.fetchMovies()
    }
    
    //Display request loading text as tableview header(e.g : Loading movies...)
    private func addTableViewHeader() {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: CGFloat(Constants.MovieListTableHeaderView.headerViewHeight))
        label.text = Constants.MovieListTableHeaderView.headerViewText
        label.textAlignment = .center
        label.addBottomBorder(color: .lightGray)
        tableView.tableHeaderView = label
    }
}


extension MovieListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let movie = dataProvider?.items[indexPath.row] as? Movie {
            Router.displayMovieDetails(forMovie: movie, target: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //If user reaches at last movie, fetch further batch of movies
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            let pageNoToLoad = (AppState.sharedState.currentPageNo < AppState.sharedState.totalPages) ? AppState.sharedState.currentPageNo + 1 : AppState.sharedState.totalPages
            dataProvider?.fetchMovies(forPageNo: pageNoToLoad, filter: self.filter)
        }
    }
}
