//
//  DBSearchFieldCell.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/6/3.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa

class DBSearchFieldCell: NSSearchFieldCell {
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI() {
        let image = NSImage(named: "searchButton")
        image?.size = NSSize(width: 17.6, height: 20)
        let searchButtonCell = NSButtonCell.init()
        searchButtonCell.image = image
        searchButtonCell.alternateImage = image
        searchButtonCell.backgroundColor = NSColor.clear
        self.searchButtonCell = searchButtonCell
        
    }
    
    override func searchTextRect(forBounds rect: NSRect) -> NSRect {
        return NSRect.init(x: 0, y: 0, width: (self.controlView?.frame.width)! - 20, height: 20)
    }
    
    override func searchButtonRect(forBounds rect: NSRect) -> NSRect {
        return NSRect.init(x: (self.controlView?.frame.width)! - 20, y: 0, width: 20, height: 20)
    }
}
