//
//  ViewController.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/5/22.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa
import Alamofire
import SDWebImage
import YYModel

fileprivate let cellReuseId = "ActionTitle"
fileprivate let itemReuseId = "MovieItem"

class DBMainViewController: NSViewController {
    let actionItem: [String] = ["正在热映", "即将上映", "Top250", "口碑榜", "北美票房榜", "新片榜"]
    var movieList: [DBMovieModel] = []
    
    @IBOutlet weak var placeholderView: NSView!
    @IBOutlet weak var tableView: NSTableView! {
        didSet {
            tableView.register(NSNib(nibNamed: "ActionCell", bundle: nil), forIdentifier: "ActionTitle")
        }
    }
    @IBOutlet weak var movieCollectionView: NSCollectionView! {
        didSet {
            movieCollectionView.register(DBMovieItem.self, forItemWithIdentifier: itemReuseId)
            let flowLayout = movieCollectionView.collectionViewLayout as? NSCollectionViewFlowLayout
            flowLayout?.itemSize = NSSize(width: 130, height: 263)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        setCollectionView()
        getInTheatersMovie()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        placeholderView.layer?.backgroundColor = NSColor.init(deviceRed: 21.0/255.0, green: 30.0/255.0, blue: 37.0/255.0, alpha: 1.0).cgColor
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    /*func getInTheatersMovieWith(city: String) ->  () -> Void {
        Alamofire.request("https://api.douban.com", method: .get, parameters: ["city": city], encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                print(response)
        }
    }*/
}

extension DBMainViewController {
    fileprivate func setCollectionView() {
        
    }
    
    fileprivate func getInTheatersMovie() {
        let params: Parameters = ["city": "杭州"]
        Alamofire.request("https://api.douban.com/v2/movie/in_theaters", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                guard let result = response.result.value as? [String: Any] else { return }
                let movies = result["subjects"] as Any
                let movieList = NSArray.yy_modelArray(with: DBMovieModel.self, json: movies) as? [DBMovieModel]
                if movieList != nil {
                    self.movieList = movieList!
                    self.movieCollectionView.reloadData()
                }
                
                
               
                
                
               /* if let result = response.result.value as? [String: Any] {
                    print(result)
                    let movies = result["subjects"] as! NSDictionary? as? [AnyHashable: Any] ?? [:]
                    for element in movies {
                        let movie = DBMovieModel.yy_model(with: element)
                        
                    }
                }*/
        }
        
        
        /*let movie = DBMovieModel()
        movie.cover = "https://img3.doubanio.com/spic/s1747553.jpg"
        movie.name = "满月之夜白鲸现"
        movie.type = "7.0"
        movie.duration = "2016"
        
        movieList = Array.init(repeating: movie, count: 100) */
    }
}

extension DBMainViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.make(withIdentifier: cellReuseId, owner: self) as? DBActionCell else { return nil }
        cell.title.stringValue = actionItem[row]
        return cell
    }
    
    func tableView(_ tableView: NSTableView, didClick tableColumn: NSTableColumn) {
        let _ = 123
    }
}

extension DBMainViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return actionItem.count
    }
}

extension DBMainViewController: NSCollectionViewDelegate {
    
}

extension DBMainViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let movieItem = collectionView.makeItem(withIdentifier: itemReuseId, for: indexPath) as? DBMovieItem else { return DBMovieItem() }
        let movie = movieList[indexPath.item]
        movieItem.cover.sd_setImage(with: URL.init(string: movie.images["large"]!), placeholderImage: nil)
        movieItem.movieName.stringValue = movie.title
        movieItem.movieType.stringValue = movie.genres.joined(separator: ",")
        movieItem.year.stringValue = movie.year
        
        return movieItem
    }
}
