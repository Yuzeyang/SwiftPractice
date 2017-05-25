//
//  DBMovieService.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/5/25.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa
import Alamofire

class DBMovieService: NSObject {
    let baseURL = "https://api.douban.com"
    
    typealias InTheaterBlock = (title: String, total: Int, start: Int, count: Int, subjects: String) -> Void
    
    func getInTheatersMovieWith(city: String) -> InTheaterBlock {
        Alamofire.get
    }
}
