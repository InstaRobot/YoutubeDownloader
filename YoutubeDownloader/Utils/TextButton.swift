//
//  TextButton.swift
//  YoutubeDownloader
//
//  Created by khoa on 20/03/2019.
//  Copyright © 2019 Fantageek. All rights reserved.
//

import AppKit
class TextButton: NSButton {
  @IBInspectable open var textColor: NSColor = NSColor.black
  @IBInspectable open var textSize: CGFloat = 10
  
  public override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func update() {
    let titleParagraphStyle = NSMutableParagraphStyle()
    titleParagraphStyle.alignment = alignment
    
    let attributes: [NSAttributedString.Key : Any] = [.foregroundColor: textColor, .font: NSFont.systemFont(ofSize: textSize), .paragraphStyle: titleParagraphStyle]
    self.attributedTitle = NSMutableAttributedString(string: self.title, attributes: attributes)
  }
}
