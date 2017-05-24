//
//  DBMainWindow.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/5/23.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa

class DBMainWindow: NSWindowController {
    let windowSize = CGSize(width: 900, height: 650)
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        if let window = window, let screen = window.screen {
            let screenFrame = screen.visibleFrame
            let x = screenFrame.midX - windowSize.width/2
            let y = screenFrame.midY - windowSize.height/2
            let origin = CGPoint(x: x, y: y)
            window.setFrame(NSRect(origin: origin, size: windowSize), display: true)
            
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true
            window.styleMask = [window.styleMask, .fullSizeContentView]
        }
    }
}
