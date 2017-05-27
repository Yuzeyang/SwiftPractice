//
//  DBMovieInTheater.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/5/26.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa

class DBMovieModel: NSObject {
    var id: String = ""
    var title: String = ""
    var alt: String = ""
    var images: [String: String] = [:]
    var rating: [String: AnyObject] = [:]
    var genres: [String] = []
    var year: String = ""
}
