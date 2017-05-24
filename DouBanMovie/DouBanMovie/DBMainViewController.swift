//
//  ViewController.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/5/22.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa

class DBMainViewController: NSViewController {
    let actionItem: [String] = ["正在热映", "即将上映", "Top250", "口碑榜", "北美票房榜", "新片榜"]
    
    @IBOutlet weak var tableView: NSTableView! {
        didSet {
            tableView.register(NSNib(nibNamed: "ActionCell", bundle: nil), forIdentifier: "ActionTitle")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension DBMainViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.make(withIdentifier: "ActionTitle", owner: self) as? DBActionCell else { return nil }
        cell.title.stringValue = actionItem[row]
        return cell
    }
}

extension DBMainViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return actionItem.count
    }
}

