//
//  Movie.swift
//  MovieApp
//
//  Created by Hardik on 19/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import Foundation

class Movie: NSObject {
    var id: Int
    var title:String
    var releaseDate: String
    var vote: Float
    var voteCount: Int
    var isAdult = false
    var language:String = "en"
    var budget: Double?
    var posterPath: String?
    var revenue: Double?
    var tagLine: String?
    
    init(id: Int, title: String, releaseDate: String, vote: Float, voteCount: Int, adultContent: Bool, language: String) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.vote = vote
        self.voteCount = voteCount
        self.isAdult = adultContent
        self.language = language
    }
}
