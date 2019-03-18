//
//  Alert.swift
//  YoutubeDownloader
//
//  Created by khoa on 18/03/2019.
//  Copyright © 2019 Fantageek. All rights reserved.
//

import AppKit

class Alert {
  static func show(message: String) {
    let alert = NSAlert()
    alert.messageText = message
    alert.informativeText = message
    alert.alertStyle = NSAlert.Style.warning
    alert.addButton(withTitle: "OK")
    alert.runModal()
  }
}
