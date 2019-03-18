//
//  AddRow.swift
//  YoutubeDownloader
//
//  Created by khoa on 18/03/2019.
//  Copyright © 2019 Fantageek. All rights reserved.
//

import AppKit

final class AddRow: NSView {
  var onPress: (() -> Void)?
  @IBOutlet weak var mp3Button: NSButton!
    
  @IBAction func onAddButtonPress(_ sender: NSButton) {
  
  }
    
  @IBAction func onMp3ButtonPress(_ sender: NSButton) {
    onPress?()
  }
}
