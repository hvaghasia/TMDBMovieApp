//
//  Filter.swift
//  MovieApp
//
//  Created by Hardik on 20/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import Foundation

struct Filter {
    var minYear: String?
    var maxYear: String?
    var sortingMode = Constants.MovieListSortType.latest
    
    init(minYearValue: String, maxYearValue: String) {
        if let minYearIntValue = UInt(minYearValue), let maxYearIntValue = UInt(maxYearValue) {
            if minYearIntValue > maxYearIntValue {
                self.minYear = maxYearValue
                self.maxYear = minYearValue
                self.sortingMode = .latest
            } else {
                self.minYear = minYearValue
                self.maxYear = maxYearValue
                self.sortingMode = .oldest
            }
        }
    }
}
