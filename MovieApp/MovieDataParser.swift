//
//  MovieDataParser.swift
//  MovieApp
//
//  Created by Hardik on 19/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import Foundation

class MovieDataParser {
    
    class func parseMovieListData(listJsonData: AnyObject, completionHandler: MovieListCompletionHandler? = nil) {
        
        // Save current page and total page count detail in shared class(AppState)
        AppState.sharedState.currentPageNo = listJsonData[Constants.ResponseKey.page] as? Int ?? -1
        AppState.sharedState.totalPages = listJsonData[Constants.ResponseKey.totalPages] as? Int ?? -1

        var movieList = [Movie]()
        for movieJsonData in listJsonData[Constants.ResponseKey.results] as! [AnyObject] {
            parseMovieData(jsonData: movieJsonData, completionHandler: { (movie: Movie?, error: Error?) in
                if let movieObj = movie {
                    movieList.append(movieObj)
                }
            })
        }
        completionHandler?(movieList, nil)
    }
    
    class func parseMovieData(jsonData: AnyObject, completionHandler: MovieDetailsCompletionHandler? = nil) {
        if let id = jsonData[Constants.ResponseKey.id] as? Int,
            let title = jsonData[Constants.ResponseKey.title] as? String,
            let releaseDate = jsonData[Constants.ResponseKey.releaseDate] as? String,
            let vote = jsonData[Constants.ResponseKey.vote] as? Float,
            let voteCount = jsonData[Constants.ResponseKey.voteCount] as? Int,
            let isAdult = jsonData[Constants.ResponseKey.adult] as? Bool,
            let language = jsonData[Constants.ResponseKey.language] as? String {
            
            let movie = Movie(id: id, title: title, releaseDate: releaseDate, vote: vote, voteCount: voteCount, adultContent: isAdult, language: language)
            
            movie.tagLine = jsonData[Constants.ResponseKey.tagline] as? String
            movie.revenue = jsonData[Constants.ResponseKey.revenue] as? Double
            movie.budget = jsonData[Constants.ResponseKey.budget] as? Double
            movie.posterPath = jsonData[Constants.ResponseKey.posterPath] as? String
            
            completionHandler?(movie, nil)
        }
    }
}
