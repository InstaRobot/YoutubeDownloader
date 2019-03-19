//
//  Label.swift
//  YoutubeDownloader
//
//  Created by khoa on 18/03/2019.
//  Copyright © 2019 Fantageek. All rights reserved.
//

import AppKit

final class Label: NSTextField {
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    
    isBezeled = false
    isEditable = false
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
}
