//
//  AppDelegate.swift
//  YoutubeDownloader
//
//  Created by Khoa Pham on 11/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private let popover = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupMenu()
        setupPopover()
    }
    
    // MARK: - Logic
    private func setupMenu() {
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("icon"))
            button.action = #selector(togglePopover(_:))
        }
    }
    
    private func setupPopover() {
        popover.behavior = .transient
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let vc = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("MainViewController"))
        popover.contentViewController = vc as! MainViewController
        
        popover.appearance = NSAppearance(named: NSAppearance.Name.aqua)
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
}

