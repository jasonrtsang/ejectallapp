//
//  AppDelegate.swift
//  EjectAll
//
//  Created by Jason Tsang on 2016-03-13.
//  Copyright © 2016 Jason Tsang. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    @IBOutlet weak var aboutPopup: NSView!
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: -1)
    
    var icon = NSImage(named: "StatusIcon")

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        icon?.isTemplate = true
        statusItem.image = icon
        statusItem.menu = statusMenu
    }
  
    @IBAction func EjectAll(_ sender: NSMenuItem) {
        let myAppleScript = "tell application \"Finder\" to eject (every disk whose ejectable is true)"
        var error: NSDictionary?
        
        let notification:NSUserNotification = NSUserNotification()
        let notificationcenter:NSUserNotificationCenter = NSUserNotificationCenter.default

        if let scriptObject = NSAppleScript(source: myAppleScript) {
            scriptObject.executeAndReturnError(&error)

            if error == nil {
                notification.subtitle = "Successful!"
                notification.informativeText = "It is now safe to unplug."
                notification.soundName = NSUserNotificationDefaultSoundName
            
            }
            else {
                notification.subtitle = "Unsuccessful"
                notification.informativeText = "Uh oh! Something prevented the ejection of all disks :("
                notification.soundName = NSUserNotificationDefaultSoundName
            }
        }

        notificationcenter.scheduleNotification(notification)
        
    }
    @IBAction func LoadAbout(_ sender: NSMenuItem) {
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @IBAction func QuitApp(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }

}

