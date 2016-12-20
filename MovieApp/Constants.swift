//
//  Constants.swift
//  MovieApp
//
//  Created by Hardik on 19/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import Foundation

typealias MovieListCompletionHandler = (_ movies: [AnyObject]?, _ error: Error?) -> Void
typealias MovieDetailsCompletionHandler = (_ movie: Movie?, _ error: Error?) -> Void
typealias DownloadImageCompletionHandler = (_ moviePosterData: Data?, _ error: Error?) -> Void

struct Constants {
    
    static let baseURL = "https://api.themoviedb.org/3/"
    static let apiKey = "a839962fbfd250d9e6f10d1a78a9eecf"
    static let getMoviesURLResourcePath = "search/movie?api_key=%@&query=titanic&language=en-US"
    static let allMoviesURLResourcePath = "discover/movie?language=en-US&api_key=%@&sort_by=%@&page=%d"

    static let movieDetailsURLResourcePath = "movie/%d?api_key=%@&language=en-US"
    
    static let imageBaseURL = "https://image.tmdb.org/t/p/"

    static let moviePosterPlaceholderImageName = "placeholder.png"
    struct ResponseKey {
        static let id = "id"
        static let title = "title"
        static let releaseDate = "release_date"
        static let vote = "vote_average"
        static let adult = "adult"
        static let language = "original_language"
        static let results = "results"
        static let voteCount = "vote_count"
        static let tagline = "tagline"
        static let revenue = "revenue"
        static let budget = "budget"
        static let posterPath = "poster_path"
        static let page = "page"
        static let totalPages = "total_pages"
    }
    
    struct MoviePosterImageSize {
        static let thumbnail = "w92"
        static let movieDetail = "original"
    }
    
    struct CellIndentifier {
        static let movieListCell = "MovieListCell"
        static let movieDetailCell = "MovieDetailCell"
    }
    
    struct MovieDetailTableViewCellTitle {
        static let title = "Title"
        static let releaseDate = "Release date"
        static let vote = "Vote"
        static let voteCount = "Vote count"
        static let adult = "Adult"
        static let language = "Language"
        static let tagline = "Tagline"
        static let budget = "Budget"
        static let revenue = "Revenue"
    }
    
    enum MovieListSortType: Int {
        case latest
        case oldest
    }
    
    struct MovieListTableHeaderView {
        static let headerViewText = "Loading Movies..."
        static let headerViewHeight = 50.0
    }
    
    struct MovieFilterAlertView {
        static let message = "Filter movies"
        static let filterButtonTitle = "Filter"
        static let cancelButtonTitle = "Cancel"
        static let minYearTxtFieldPlaceholder = "Add min year"
        static let maxYearTxtFieldPlaceholder = "Add max year"
    }
    
    struct MovieFilterErrorAlertView {
        static let missingValue = "Please enter valid filter value."
        static let invalidValue = "Mininum year should not be greater than maximum year."
        static let buttonTitle = "Ok"
    }
    
    struct ScreenTitle {
        static let movieList = "Movies"
    }
    
    struct StoryboardVCID {
        static let movieDetailVC = "MovieDetailsViewController"
    }
    
    struct StoryboardName {
        static let main = "Main"
    }
}
