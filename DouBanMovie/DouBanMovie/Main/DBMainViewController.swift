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
    var currentIndex = 0
    
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
}

extension DBMainViewController {
    fileprivate func getInTheatersMovie() {
        DBMovieService.getInTheatersMovieWith("杭州") { [weak self](error, data) -> Void in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            self?.movieList.removeAll()
            self?.movieList = data!
            self?.movieCollectionView.reloadData()
        }
    }
    
    fileprivate func getComingSoonMovie() {
        DBMovieService.getComingSoonWith(0, count: 20) { [weak self](error, data) -> Void in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            self?.movieList.removeAll()
            self?.movieList = data!
            self?.movieCollectionView.reloadData()
        }
    }
    
    fileprivate func getTop250Movie() {
        DBMovieService.getTop250With(0, count: 20) { [weak self](error, data) -> Void in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            self?.movieList.removeAll()
            self?.movieList = data!
            self?.movieCollectionView.reloadData()
        }
    }
    
    fileprivate func getWeeklyMovie() {
        DBMovieService.getWeeklyMovieWith { [weak self](error, data) -> Void in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            self?.movieList.removeAll()
            self?.movieList = data!
            self?.movieCollectionView.reloadData()
        }
    }
    
    fileprivate func getUSBoxMovie() {
        DBMovieService.getUSBoxMovieWith { [weak self](error, data) -> Void in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            self?.movieList.removeAll()
            self?.movieList = data!
            self?.movieCollectionView.reloadData()
        }
    }
    
    fileprivate func getNewxMovie() {
        DBMovieService.getNewMovieWith { [weak self](error, data) -> Void in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            self?.movieList.removeAll()
            self?.movieList = data!
            self?.movieCollectionView.reloadData()
        }
    }
}

extension DBMainViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.make(withIdentifier: cellReuseId, owner: self) as? DBActionCell else { return nil }
        cell.title.stringValue = actionItem[row]
        return cell
    }
    
    func tableView(_ tableView: NSTableView, selectionIndexesForProposedSelection proposedSelectionIndexes: IndexSet) -> IndexSet {
        var index = currentIndex
        if proposedSelectionIndexes.first! != Optional.none {
           index = proposedSelectionIndexes.first!
        }
        switch index {
        case 0:
            getInTheatersMovie()
            break
        case 1:
            getComingSoonMovie()
            break
        case 2:
            getTop250Movie()
            break
        case 3:
            getWeeklyMovie()
            break
        case 4:
            getUSBoxMovie()
            break
        case 5:
            getNewxMovie()
            break
        default:
            print("unknow type")
            break
        }
        
        return proposedSelectionIndexes
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
