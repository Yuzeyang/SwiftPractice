//
//  DBMovieDetailService.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/7/1.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa

private let baseURL = "https://api.douban.com/"

private let MovieDetailAPI = "/v2/movie/subject"

typealias movieDetailCallback = (_ error: NSError, _ detail: DBMovieDetailModel?) -> Void

class DBMovieDetailService: NSObject {
    class func getMovieDetailWith(_ id: String, callback:movieDetailCallback) {
        
    }
}
