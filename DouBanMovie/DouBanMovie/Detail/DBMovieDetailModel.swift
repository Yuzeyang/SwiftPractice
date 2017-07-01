//
//  DBMovieDetailModel.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/7/1.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa

class DBMovieDetailModel: NSObject {
    //var id: String = "";
    var title: String = "";
    var year: String = "";
    
    var original_title: String = "";
    var directors: Array<String> = [];
    var writers: Array<String> = [];
    var casts: Array<String> = [];
    var genres: Array<String> = [];
    var countries: Array<String> = [];
    var languages: Array<String> = [];
    var mainland_pubdate: String = "";
    var durations: Array<String> = [];
    var aka: Array<String> = [];
    var rating: Dictionary = [String: Any]();
    var ratings_count: Int = 0;
    var wish_count: Int = 0;
    var collect_count: Int = 0;
    
    var summary: String = "";
    
    var photos: Array<String> = [];
    
    var popular_reviews: Array<String> = [];
}
