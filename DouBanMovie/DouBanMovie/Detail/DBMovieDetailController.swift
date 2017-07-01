//
//  DBMovieDetailController.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/6/24.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa

class DBMovieDetailController: NSViewController {
//    @IBAction weak var poster: NSImageView! {
//        didSet {
//            poster.wantsLayer = true
//            poster.layer?.contentsGravity = kCAGravityResizeAspectFill
//            poster.layer?.contents = poster.image
//        }
//    }
    @IBOutlet weak var poster: NSImageView! {
        didSet {
            poster.wantsLayer = true
            poster.layer?.contentsGravity = kCAGravityResizeAspectFill
            poster.layer?.contents = poster.image
        }
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismissViewController(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do view setup here.
    }
}

extension DBMovieDetailController {
    fileprivate func initUI() {
        
    }
    
    fileprivate func initDataSource() {
        
    }
}



