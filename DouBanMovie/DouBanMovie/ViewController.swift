//
//  ViewController.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/5/22.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var bgView: NSView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = NSRect.init(origin: .zero, size: .init(width: 400, height: 400))
        self.bgView.wantsLayer = true
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear() {
        self.bgView?.layer?.backgroundColor = NSColor.orange.cgColor
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

