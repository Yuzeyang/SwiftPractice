//
//  DBCollectionHeaderView.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/6/8.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa

typealias RefreshHandler = () -> Void

class DBCollectionHeaderView: NSView {
    @IBOutlet weak var currentType: NSTextField!
    @IBAction func refreshAction(_ sender: Any) {
        refreshHandler?()
    }
    
    var refreshHandler: RefreshHandler?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    func initUI() {
        wantsLayer = true
        layer?.backgroundColor = NSColor.white.cgColor
    }
}


