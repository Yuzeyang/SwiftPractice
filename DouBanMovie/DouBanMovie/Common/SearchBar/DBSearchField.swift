//
//  DBSearchField.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/6/3.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa
import SnapKit

class DBSearchField: NSSearchField {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here.
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI() {
        let placeholdeString = NSMutableAttributedString.init(string: "搜索电影...")
        placeholdeString.setAttributes([NSForegroundColorAttributeName: NSColor.white], range: NSRange.init(location: 0, length: placeholdeString.length))
        self.placeholderAttributedString = placeholdeString
    }
    
//    override func rectForSearchButton(whenCentered isCentered: Bool) -> NSRect {
//        return NSRect.init(x: self.frame.width - 20, y: self.frame.midY, width: 20, height: 20)
//    }
}
