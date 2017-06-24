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
import SnapKit

fileprivate let cellReuseId = "ActionTitle"
fileprivate let itemReuseId = "MovieItem"

enum DBMovieType: String {
    // "口碑榜" and "新片榜" 需要申请权限
    case InTheaters = "正在热映"
    case ComingSoon = "即将上映"
    case Top250 = "Top250"
    case USBox = "北美票房榜"
    
    static var count: Int {
        return DBMovieType.USBox.hashValue + 1
    }

    static func valueWith(_ raw: Int) -> DBMovieType? {
        switch raw {
        case 0:
            return .InTheaters
        case 1:
            return .ComingSoon
        case 2:
            return .Top250
        case 3:
            return .USBox
        default:
            return nil
        }
    }
}

class DBMainViewController: NSViewController {
    var movieList: [DBMovieModel] = []
    var currentIndex = 0
    
    var movieSearchView: DBSearchView?
    @IBOutlet weak var tableView: NSTableView! {
        didSet {
            tableView.register(NSNib(nibNamed: "DBActionCell", bundle: nil), forIdentifier: "ActionTitle")
        }
    }
    @IBOutlet weak var movieCollectionView: NSCollectionView! {
        didSet {
            movieCollectionView.register(DBMovieItem.self, forItemWithIdentifier: itemReuseId)
            
            let flowLayout = movieCollectionView.collectionViewLayout as? NSCollectionViewFlowLayout
            flowLayout?.itemSize = NSSize(width: 150, height: 263)
        }
    }
    let toggle: MacActivityIndicator = {
        let view = MacActivityIndicator()
        view.direction = .anticlockwise
        view.speed = 1.0
        view.image = NSImage(named: "loading")
        return view
    }()
    var headerView: DBCollectionHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initDataSource()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension DBMainViewController {
    fileprivate func initUI() {
        tableView.delegate = self
        tableView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        movieSearchView = try! DBSearchView.view(withOwner: self) as! DBSearchView
        movieSearchView?.searchAction = { (query) in
            DBMovieService.searchMovieWith(query, { [weak self](error, data) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                self?.movieList.removeAll()
                self?.movieList = data!
                self?.movieCollectionView.reloadData()
            })
        }
        self.view.addSubview(movieSearchView!)
        movieSearchView?.snp.makeConstraints({ (make) -> Void in
            make.left.top.equalTo(0)
            make.width.equalTo(175)
            make.height.equalTo(84)
        })
    
        toggle.frame = NSRect(x: movieCollectionView.frame.width/2 + tableView.frame.width - 25, y: movieCollectionView.frame.midY - 25, width: 50, height: 50)
        
        headerView = try! DBCollectionHeaderView.view(withOwner: self) as! DBCollectionHeaderView
        view.addSubview(headerView!)
        headerView?.snp.makeConstraints({ (make) in
            make.top.right.equalTo(0)
            make.width.equalTo(725)
            make.height.equalTo(84)
        })
        headerView?.currentType.stringValue = (DBMovieType.valueWith(currentIndex)?.rawValue)!
    }
    
    fileprivate func initDataSource() {
        getInTheatersMovie()
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        movieList.removeAll()
        movieCollectionView.reloadData()
        
        let tableView = notification.object as! NSTableView
        
        let lastCell = tableView.view(atColumn: 0, row: currentIndex, makeIfNecessary: true) as? DBActionCell
        lastCell?.isSelected = false
        currentIndex = tableView.selectedRow
        let currentCell = tableView.view(atColumn: 0, row: currentIndex, makeIfNecessary: true) as? DBActionCell
        currentCell?.isSelected = true
        
        headerView?.currentType.stringValue = (DBMovieType.valueWith(currentIndex)?.rawValue)!
        
        switch currentIndex {
        case 0:
            getInTheatersMovie()
            break
        case 1:
            getComingSoonMovie()
            break
        case 2:
            getTop250Movie()
            break
            /*case 3:
             getWeeklyMovie()
             break*/
        case 3:
            getUSBoxMovie()
            break
            /*case 5:
             getNewxMovie()
             break*/
        default:
            print("unknow type")
            break
        }
    }
    
    fileprivate func getInTheatersMovie() {
        toggle.startAnimationWith(view)
        DBMovieService.getInTheatersMovieWith("杭州") { [weak self](error, data) -> Void in
            self?.toggle.stopAnimationWithSuperView()
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
        toggle.startAnimationWith(view)
        DBMovieService.getComingSoonWith(0, count: 20) { [weak self](error, data) -> Void in
            self?.toggle.stopAnimationWithSuperView()
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
        toggle.startAnimationWith(view)
        DBMovieService.getTop250With(0, count: 20) { [weak self](error, data) -> Void in
            self?.toggle.stopAnimationWithSuperView()
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            self?.movieList.removeAll()
            self?.movieList = data!
            self?.movieCollectionView.reloadData()
        }
    }
    
    /*fileprivate func getWeeklyMovie() {
        DBMovieService.getWeeklyMovieWith { [weak self](error, data) -> Void in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            self?.movieList.removeAll()
            self?.movieList = data!
            self?.movieCollectionView.reloadData()
        }
    }*/
    
    fileprivate func getUSBoxMovie() {
        toggle.startAnimationWith(view)
        DBMovieService.getUSBoxMovieWith { [weak self](error, data) -> Void in
            self?.toggle.stopAnimationWithSuperView()
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            self?.movieList.removeAll()
            self?.movieList = data!
            self?.movieCollectionView.reloadData()
        }
    }
    
    /*fileprivate func getNewxMovie() {
        DBMovieService.getNewMovieWith { [weak self](error, data) -> Void in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            self?.movieList.removeAll()
            self?.movieList = data!
            self?.movieCollectionView.reloadData()
        }
    }*/
}

extension DBMainViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.make(withIdentifier: cellReuseId, owner: self) as? DBActionCell else { return nil }
        cell.title.stringValue = (DBMovieType.valueWith(row)?.rawValue)!
        cell.isSelected = (currentIndex == row)
        return cell
    }
}

extension DBMainViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return DBMovieType.count
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
