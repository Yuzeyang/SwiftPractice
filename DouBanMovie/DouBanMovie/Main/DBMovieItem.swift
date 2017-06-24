//
//  DBMovieItem.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/5/25.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa

class DBMovieItem: NSCollectionViewItem {
    @IBOutlet weak var cover: NSImageView!
    @IBOutlet weak var movieName: NSTextField!
    @IBOutlet weak var movieType: NSTextField!
    @IBOutlet weak var year: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        view.layer?.backgroundColor = NSColor.white.cgColor
    }
    
}
