//
//  DBSearchView.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/6/3.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa

class DBSearchView: NSView {
    @IBOutlet weak var searchField: NSTextField!
    @IBOutlet weak var line: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setUI() {
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.init(deviceRed: 206.0/255.0, green: 76.0/255.0, blue: 74.0/255.0, alpha: 1.0).cgColor
        line.layer?.backgroundColor = NSColor.white.cgColor
        let placeholder = NSMutableAttributedString.init(string: " 搜索电影...")
        placeholder.addAttributes([NSForegroundColorAttributeName: NSColor.white, NSFontAttributeName: NSFont.systemFont(ofSize: 13.0)], range: NSRange.init(location: 0, length: placeholder.length))
        searchField.placeholderAttributedString = placeholder
        searchField.focusRingType = .none
     }
}
