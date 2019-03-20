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
    onPress?()
  }
    
  @IBAction func onMp3ButtonPress(_ sender: NSButton) {
    RuntimeConfig.savedAsMp3 = sender.state == .on
  }
  
  override func viewDidMoveToSuperview() {
    super.viewDidMoveToSuperview()
    
    subviews.forEach {
      guard let textButton = $0 as? TextButton else {
        return
      }

      textButton.textColor = Colors.text
      textButton.textSize = 13
      textButton.update()
    }
  }
}
