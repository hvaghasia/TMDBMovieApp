//
//  AppState.swift
//  MovieApp
//
//  Created by Hardik on 20/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import Foundation

class AppState {
    
    static let sharedState = AppState()
    
    var currentPageNo: Int = 0
    var totalPages: Int = 1
    
    func resetPageDetails() {
        currentPageNo = 0
        totalPages = 1
    }
}
