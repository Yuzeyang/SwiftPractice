//
//  DBMovieService.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/5/25.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa
import Alamofire

private let baseURL = "https://api.douban.com/"

private let InTheatersAPI = "v2/movie/in_theaters"
private let ComingSoonAPI = "v2/movie/coming_soon"
private let Top250API = "v2/movie/top250"
private let WeeklyAPI = "v2/movie/weekly"
private let USBoxAPI = "v2/movie/us_box"
private let NewMoviesAPI = "v2/movie/new_movies"
private let SearchAPI = "v2/movie/search"

typealias InTheatersCallback = (_ error: NSError?, _ movies: [DBMovieModel]?) -> Void
typealias ComingSoonCallback = (_ error: NSError?, _ movies: [DBMovieModel]?) -> Void
typealias Top250Callback = (_ error: NSError?, _ movies: [DBMovieModel]?) -> Void
typealias WeeklyCallback = (_ error: NSError?, _ movies: [DBMovieModel]?) -> Void
typealias USBoxCallback = (_ error: NSError?, _ movies: [DBMovieModel]?) -> Void
typealias NewMoviesCallback = (_ error: NSError?, _ movies: [DBMovieModel]?) -> Void
typealias MovieSearchCallback = (_ error: NSError?, _ movie: [DBMovieModel]?) -> Void

class DBMovieService: NSObject {
    
    class func getInTheatersMovieWith(_ city: String, callback: InTheatersCallback?) {
        let params: Parameters = ["city": city]
        Alamofire.request(baseURL + InTheatersAPI, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                guard let callback = callback else { return }
                var movieList: [DBMovieModel]?
                
                if let error = handleError(response) {
                    callback(error, movieList)
                    return
                }
                
                let movies = (response.result.value as! [String: Any])["subjects"] as Any
                movieList = NSArray.yy_modelArray(with: DBMovieModel.self, json: movies) as? [DBMovieModel]
                callback(nil, movieList)
        }
    }
    
    class func getComingSoonWith(_ start: Int, count: Int, callback: ComingSoonCallback?) {
        let params: Parameters = ["start": start, "count": count]
        Alamofire.request(baseURL + ComingSoonAPI, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                guard let callback = callback else { return }
                var movieList: [DBMovieModel]?
                
                if let error = handleError(response) {
                    callback(error, movieList)
                    return
                }
                
                let movies = (response.result.value as! [String: Any])["subjects"] as Any
                movieList = NSArray.yy_modelArray(with: DBMovieModel.self, json: movies) as? [DBMovieModel]
                callback(nil, movieList)
            }
    }
    
    class func getTop250With(_ start: Int, count: Int, callback: ComingSoonCallback?) {
        let params: Parameters = ["start": start, "count": count]
        Alamofire.request(baseURL + Top250API, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                guard let callback = callback else { return }
                var movieList: [DBMovieModel]?
                
                if let error = handleError(response) {
                    callback(error, movieList)
                    return
                }
                
                let movies = (response.result.value as! [String: Any])["subjects"] as Any
                movieList = NSArray.yy_modelArray(with: DBMovieModel.self, json: movies) as? [DBMovieModel]
                callback(nil, movieList)
        }
    }
    
    class func getWeeklyMovieWith(_ callback: InTheatersCallback?) {
        Alamofire.request(baseURL + WeeklyAPI)
            .responseJSON { (response) in
                guard let callback = callback else { return }
                var movieList: [DBMovieModel]?
                
                if let error = handleError(response) {
                    callback(error, movieList)
                    return
                }
                
                let movies = (response.result.value as! [String: Any])["subjects"] as Any
                movieList = NSArray.yy_modelArray(with: DBMovieModel.self, json: movies) as? [DBMovieModel]
                callback(nil, movieList)
        }
    }
    
    class func getUSBoxMovieWith(_ callback: InTheatersCallback?) {
        Alamofire.request(baseURL + USBoxAPI)
            .responseJSON { (response) in
                guard let callback = callback else { return }
                var movieList: [DBMovieModel]?
                
                guard let result = response.result.value as? [String: Any] else {
                    let error = NSError.init(domain: NSURLErrorDomain, code: 404, userInfo: [NSLocalizedDescriptionKey: "数据请求失败/(ㄒoㄒ)/~~"])
                    callback(error, movieList)
                    return
                }
                
                if let code = result["code"] {
                    let msg = result["msg"] as! String
                    let error = NSError.init(domain: NSURLErrorDomain, code: code as! Int, userInfo: [NSLocalizedDescriptionKey: msg])
                    callback(error, movieList)
                    return
                }
                
                let boxes = result["subjects"] as Any
                let boxList = NSArray.yy_modelArray(with: DBBoxModel.self, json: boxes) as? [DBBoxModel]
                movieList = boxList?.map({ element in
                    element.subject!
                })
                callback(nil, movieList)
        }
    }
    
    class func getNewMovieWith(_ callback: InTheatersCallback?) {
        Alamofire.request(baseURL + NewMoviesAPI)
            .responseJSON { (response) in
                guard let callback = callback else { return }
                var movieList: [DBMovieModel]?
                
                if let error = handleError(response) {
                    callback(error, movieList)
                    return
                }
                
                let movies = (response.result.value as! [String: Any])["subjects"] as Any
                movieList = NSArray.yy_modelArray(with: DBMovieModel.self, json: movies) as? [DBMovieModel]
                callback(nil, movieList)
        }
    }
    
    class func searchMovieWith(_ name: String, _ callback: MovieSearchCallback?) {
        let requestURL = baseURL + SearchAPI + "{\(name)}"
        let params: Parameters = ["q": name]
        Alamofire.request(baseURL + SearchAPI, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
        .responseJSON { (response) in
            guard let callback = callback else { return }
            var movieList: [DBMovieModel]?
            
            if let error = handleError(response) {
                callback(error, movieList)
                return
            }
            
            let movies = (response.result.value as! [String: Any])["subjects"] as Any
            movieList = NSArray.yy_modelArray(with: DBMovieModel.self, json: movies) as? [DBMovieModel]
            callback(nil, movieList)
        }
    }
    
    fileprivate class func handleError(_ response: DataResponse<Any>) -> NSError? {
        var error: NSError? = nil
        guard let result = response.result.value as? [String: Any] else {
            error = NSError.init(domain: NSURLErrorDomain, code: 404, userInfo: [NSLocalizedDescriptionKey: "数据请求失败/(ㄒoㄒ)/~~"])
            return error
        }
        
        if let code = result["code"] {
            let msg = result["msg"] as! String
            error = NSError.init(domain: NSURLErrorDomain, code: code as! Int, userInfo: [NSLocalizedDescriptionKey: msg])
            return error
        }
        return error
    }
}
