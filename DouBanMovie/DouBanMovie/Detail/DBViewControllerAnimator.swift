//
//  DBViewControllerAnimator.swift
//  DouBanMovie
//
//  Created by 宫城 on 2017/6/24.
//  Copyright © 2017年 宫城. All rights reserved.
//

import Cocoa

class DBViewControllerAnimator: NSObject, NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        viewController.view.wantsLayer = true
        viewController.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
        fromViewController.view.addSubview(viewController.view)
        var frame = NSRectToCGRect(fromViewController.view.frame)
        frame = frame.insetBy(dx: 200, dy: 10)
        frame = NSRect(x: 200, y: 10, width: 680, height: 546)
        viewController.view.frame = frame
        viewController.view.layer?.backgroundColor = NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9).cgColor
        viewController.view.layer?.cornerRadius = 4.0
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        viewController.view.wantsLayer = true
        viewController.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            context.duration = 0.3
            viewController.view.animator().alphaValue = 0.0
        }, completionHandler: nil)
    }
}
