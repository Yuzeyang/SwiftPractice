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

typealias InTheatersCallback = (_ error: NSError?, _ movies: [DBMovieModel]?) -> Void
typealias ComingSoonCallback = (_ error: NSError?, _ movies: [DBMovieModel]?) -> Void
typealias Top250Callback = (_ error: NSError?, _ movies: [DBMovieModel]?) -> Void


class DBMovieService: NSObject {
    
    class func getInTheatersMovieWith(_ city: String, callback: InTheatersCallback?) {
        let params: Parameters = ["city": city]
        Alamofire.request(baseURL + InTheatersAPI, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
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
                
                let movies = result["subjects"] as Any
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
                
                let movies = result["subjects"] as Any
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
                
                let movies = result["subjects"] as Any
                movieList = NSArray.yy_modelArray(with: DBMovieModel.self, json: movies) as? [DBMovieModel]
                callback(nil, movieList)
        }
    }
}
