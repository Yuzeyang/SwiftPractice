//
//  DBActionCell.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/5/24.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa

class DBActionCell: NSTableCellView {
    
    @IBOutlet weak var selectedView: NSView!
    @IBOutlet weak var title: NSTextField!

    var isSelected: Bool! = false {
        didSet {
            selectedView.isHidden = !isSelected
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        selectedView.layer?.backgroundColor = NSColor(red: 28.0/255.0, green: 36.0/255.0, blue: 43.0/255.0, alpha: 1.0).cgColor
        selectedView.layer?.cornerRadius = 4.0
        // Drawing code here.
    }
    
}
