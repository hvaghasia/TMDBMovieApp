//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Hardik on 19/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: NSObject {
    
    static let sharedManager = NetworkManager()
    var session: URLSession?
    
    private override init() {
        super.init()
        setUp()
    }
    
    private func setUp() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    //Webservice to fetch movie list according to filter and sorting mode
    func getMovies(forPageNo pageNo: Int = 1, sortedBy sortType: Constants.MovieListSortType = .latest, filterMinYear minYear: String? = nil, filterMaxYear maxYear: String? = nil, completionHandler: MovieListCompletionHandler? = nil) {
        let sortDescription = (sortType == .latest) ? "release_date.desc" : "release_date.asc"
        var filterString = ""
        if let oldestYearValue = minYear, let latestYearValue = maxYear {
            filterString = "&primary_release_date.gte=\(oldestYearValue)&primary_release_date.lte=\(latestYearValue)"
        }
        let resourcePath = String(format: Constants.allMoviesURLResourcePath, Constants.apiKey, sortDescription, pageNo) + filterString
        let url = URL(string: Constants.baseURL + resourcePath)
        let task = session?.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if let err = error {
                completionHandler?(nil, err)
                return
            }
            
            if let responseData = data {
                do {
                    let movieResponse = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                    MovieDataParser.parseMovieListData(listJsonData: movieResponse as AnyObject, completionHandler: completionHandler)
                } catch {
                    print("JSON Serialization error : \(error)")
                    completionHandler?(nil, error)
                }
            }
        })
        task?.resume()
    }
    
    //Webservice to fetch movie details for given movie id
    func getMovieDetails(forMovieId movieId: Int, completionHandler: MovieDetailsCompletionHandler? = nil) {
        let resourcePath = String(format: Constants.movieDetailsURLResourcePath, movieId, Constants.apiKey)
        let url = URL(string: Constants.baseURL + resourcePath)
        let task = session?.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if let err = error {
                completionHandler?(nil, err)
                return
            }
            
            if let responseData = data {
                do {
                    let movieResponse = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                    MovieDataParser.parseMovieData(jsonData: movieResponse as AnyObject, completionHandler: completionHandler)
                } catch {
                    print("JSON Serialization error : \(error)")
                }
            }
        })
        task?.resume()
    }
    
    //Webservice to fetch movie poster of given size
    func getMoviePoster(withPosterPath posterPath: String, posterSize: String, completionHandler: DownloadImageCompletionHandler? = nil) {
        
        let configuration = URLSessionConfiguration.default
        let imageSession = URLSession(configuration: configuration)
        
        let resourcePath = posterSize + "/" + posterPath
        let url = URL(string: Constants.imageBaseURL + resourcePath)
        let task = imageSession.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if let err = error {
                completionHandler?(nil, err)
                return
            }
            
            if let responseData = data {
                completionHandler?(responseData, nil)
            }
        })
        task.resume()
    }
}


